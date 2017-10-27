---
title: Testing jQuery's AJAX "script" and "jsonp" requests using Sinon.JS' fake server
date: 2017-01-25 16:28:00 +0600
categories: programming
tags: testing yii yii2 javascript jquery ajax nodejs sinon chai mocha
---

## Problems

### Introduction

***

During writing [tests for yii.js] in Yii 2 framework I faced with problem of testing AJAX requests with types `script` 
and `jsonp`. I use [Sinon.JS] as a stubbing library, it has a wonderful feature called [Fake server] which comes in 
handy exactly for testing AJAX. Unfortunately there are some problems with these types:

- Cross-domain requests do not work neither in Node nor in browser.
- In Node.js they do not work at all, even the requests within the same site / domain.

***

If you are not interested in details you can skip them and read the [Solution section] right away.

Let's abstract from test frameworks and assertion libraries and just use jQuery and Sinon.JS.

### Regular requests

In case of using regular `GET` and `POST` requests:

```js
var server = sinon.fakeServer.create();

// Requests within the same domain

$.get('/js/test.js');
$.post('/js/test.js');

// Cross-domain requests

$.get('http://external.site/js/test.js');
$.post('http://external.site/js/test.js');

console.log(server.requests.length);
```

in both browser and Node the output will be `4` meaning that all requests were created and stubbed (even cross-domain 
requests). In browser console you can see that no real requests were sent. We can create default response before calling
them: 

```js
var response = [200, {'Content-Type': 'text/javascript'}, 'var foobar = 1;'];
server.respondWith(/(http:\/\/external\.site)\/js\/.+\.js/, response);
```

and then call `server.respond()` after specific request and it will be resolved.

Or we can respond to single request:

```js
server.requests[0].respond(200, {'Content-Type': 'text/javascript'}, 'var foobar = 1;');
```

So far, so good. Everything works fine with regular `GET` and `POST` requests.

### `script` and `jsonp` requests

Now let's test `script` and `jsonp` requests:
 
```js
var server = sinon.fakeServer.create();

// Requests within the same domain

$.getScript('/js/test.js');
$.ajax({
    url: '/js/test.js',
    dataType: 'jsonp'
});

console.log(server.requests.length);

// Cross-domain requests

$.getScript('http://external.site/js/test.js');
$.ajax({
    url: 'http://external.site/js/test.js',
    dataType: 'jsonp'
});

console.log(server.requests.length);
```

In browser the output will be:

```
2
2
```

It means that only requests within the same domain were successfully created and stubbed, the cross-domain requests were 
not and they will trigger network activity (you can verify that using the browser's debug tools).
  
In Node the situation is even worse, the output is:

```
0
0
```

This means that no requests were created and stubbed at all and we can't test anything.

With added assertion (using [Chai] for example):

```js
assert.lengthOf(server.requests, 4);
```

it will fail with:

```
AssertionError: expected [] to have a length of 4 but got 2
```

in browser and with:

```
AssertionError: expected [] to have a length of 4 but got 0
```

in Node.js environment. 

In case of responding to specific request directly:
 
```js
server.requests[0].respond(200, {'Content-Type': 'text/javascript'}, 'var foobar = 1;');
```

test will fail earlier even before assertion:

```
TypeError: Cannot read property 'respond' of undefined
```

That's because `server.requests` is an empty array.

### Explanation and recommended solution

Why this happens?

Many of you probably already know that jQuery's `$.ajax` is a wrapper of native JS object [XMLHttpRequest]. Under the 
hood Sinon's fake server uses wrapper of `XMLHttpRequest` called [FakeXMLHttpRequest] to fake and track XHR requests.
 
From the [Sinon.JS JSONP documentation]:

> JSON-P doesn’t use Ajax requests, which is what the fake server is concerned with. A JSON-P request actually creates 
> a script element and inserts it into the document.

jQuery also mentions it in [jQuery.getJson() docs]:

> JSONP and cross-domain GET requests do not use XHR

Well, no XHR requests will be sent when using JSONP. Sinon's documentation recommends just to stub jQuery:
 
```js
sinon.stub(jQuery, "ajax");
sinon.assert.calledOnce(jQuery.ajax);
```

However this was not acceptable in my case because in [tested yii.js functionality] within [$.ajaxPrefilter] there is 
some handling of potential concurrent requests. Some of them could be aborted, so I need to test their state too. So I 
decided to go further and find solution to this problem which would work with fake server. 

## Searching for a better solution 

Googling did not help much. Even there are some similar questions on Github and Stack Overflow, some of them are still 
without an answer and there are some answers recommending the same thing - to stub jQuery directly.

OK, the problem with cross-domain requests is clear, but what's wrong with `script` requests within the same site / 
domain such as `$.getScript('/js/test.js')` in Node.js? Because I use Node.js for running tests, for me this was the
higher priority problem. Let's take a look at the jQuery's sources and find out:

```js
// Bind script tag hack transport
jQuery.ajaxTransport( "script", function( s ) {

    // This transport only deals with cross domain requests
    if ( s.crossDomain ) {
        var script, callback;
        return {
            send: function( _, complete ) {
                script = jQuery( "<script>" ).prop( {
                    charset: s.scriptCharset,
                    src: s.url
                } ).on(
                    "load error",
                    callback = function( evt ) {
                        script.remove();
                        callback = null;
                        if ( evt ) {
                            complete( evt.type === "error" ? 404 : 200, evt.type );
                        }
                    }
                );

                // Use native DOM manipulation to avoid our domManip AJAX trickery
                document.head.appendChild( script[ 0 ] );
            },
            abort: function() {
                if ( callback ) {
                    callback();
                }
            }
        };
    }
} );
```

As you can see if `crossDomain` option of request is `true`, request will be handled in a special way, by inserting
`script` tag in the document's head section. Let's see the value of this option in `script` request while preparing XHR 
in Node with url `/js/test.js`:

```js
$.ajaxPrefilter('script', function (options) {
    console.log(options.crossDomain);
});
```

And it will be `true`. Weird, right?

Now let's figure out how this option's value is calculated in jQuery:
 
```js
// A cross-domain request is in order when the origin doesn't match the current origin.
if ( s.crossDomain == null ) {
    urlAnchor = document.createElement( "a" );

    // Support: IE <=8 - 11, Edge 12 - 13
    // IE throws exception on accessing the href property if url is malformed,
    // e.g. http://example.com:80x/
    try {
        urlAnchor.href = s.url;

        // Support: IE <=8 - 11 only
        // Anchor's host property isn't correctly set when s.url is relative
        urlAnchor.href = urlAnchor.href;
        s.crossDomain = originAnchor.protocol + "//" + originAnchor.host !==
            urlAnchor.protocol + "//" + urlAnchor.host;
    } catch ( e ) {

        // If there is an error parsing the URL, assume it is crossDomain,
        // it can be rejected by the transport if it is invalid
        s.crossDomain = true;
    }
}
```

`originAnchor` variable is declared above:

```js
// Anchor tag for parsing the document origin
originAnchor = document.createElement( "a" );
originAnchor.href = location.href;
```

If we debug compared origins:

```js
console.log('origin - ', originAnchor.protocol + "//" + originAnchor.host); // => 'origin - about://'
console.log('current origin - ', urlAnchor.protocol + "//" + urlAnchor.host); // => 'current origin - ://'
```

it's clearly that with such URLs they will always be different, thus in Node.js environment `crossDomain` option will 
always be `true` even with regular `GET` or `POST` requests! That's because:

```js
console.log(window.location.href); // => 'about:blank'
console.log(window.location.protocol); // => 'about:'
```

So... we are working on the [blank page]! Even it seems absolutely logical now, it can be hard to guess at the very
beginning.

By the way `jsonp` request behaves like a `script` request too because of that delegation: 

```js
// Detect, normalize options and install callbacks for jsonp requests
jQuery.ajaxPrefilter( "json jsonp", function( s, originalSettings, jqXHR ) {

    var callbackName, overwritten, responseContainer,
        jsonProp = s.jsonp !== false && ( rjsonp.test( s.url ) ?
            "url" :
            typeof s.data === "string" &&
                ( s.contentType || "" )
                    .indexOf( "application/x-www-form-urlencoded" ) === 0 &&
                rjsonp.test( s.data ) && "data"
        );

    // Handle if the expected data type is "jsonp" or we have a parameter to set
    if ( jsonProp || s.dataTypes[ 0 ] === "jsonp" ) {

        // Omitted for brevity

        // Delegate to script
        return "script";
    }
} );
```

## Solution

And it finally dawned on me that we can just make these requests non-cross-domain and act as regular XHRs! We are in 
testing environment anyway.

Even is's possible by adding `window.location.protocol` if front of the url, it can cause additional troubles in
handling of absolute URLs and is not clean and flexible.

Thanks to [$.ajaxPrefilter], we have access to requests's options and can modify them as we need:

```js
$.ajaxPrefilter('script', function (options) {
    options.crossDomain = false;
});
```

This will work for `script` and `jsonp` requests. Or we can activate this for all requests:
 

```js
$.ajaxPrefilter(function (options) {
    options.crossDomain = false;
});
```

Note that once attached, `$.ajaxPrefilter` can not be detached as regular event handler. This is not a problem if you 
are going to stub all AJAX requests.
 
Otherwise if you need this only for certain test suite, you can create additional callback and call it within the 
`$.ajaxPrefilter`, then reset it to empty function when it's not needed. With [Mocha] for example you can involve 
`before` and `after` handlers:

```js
var prefilterCallback = function (options) {
    options.crossDomain = false;
};

before(function () {
    $.ajaxPrefilter(function (options) {
        prefilterCallback(options);
    });
});

after(function () {
    prefilterCallback = function () {        
    };
});
``` 

## Conclusion

I'm satisfied with this solution, it's simple and requires very few code to write. Before figuring that out I had the 
[solution based on custom types] and [$.ajaxSetup], it worked but was more verbose. What's interesting, I started to
write this post about it and found a better solution during the process of writing. Yes, sometimes this happens too.
    
One more problem solved.

[Tests for yii.js]: https://github.com/yiisoft/yii2/pull/13316
[Sinon.JS]: http://sinonjs.org/
[Fake server]: http://sinonjs.org/docs/#fakeServer
[Solution section]: #solution
[Chai]: http://chaijs.com/
[XMLHttpRequest]: https://developer.mozilla.org/en/docs/Web/API/XMLHttpRequest
[FakeXMLHttpRequest]: http://sinonjs.org/docs/#FakeXMLHttpRequest
[Sinon.JS JSONP documentation]: http://sinonjs.org/docs/#json-p
[jQuery.getJson() docs]: http://api.jquery.com/jquery.getjson/
[Tested yii.js functionality]: https://github.com/yiisoft/yii2/blob/37f19a02569833a9e49d2473439d9739444e78f8/framework/assets/yii.js#L381-L441
[$.ajaxPrefilter]: http://api.jquery.com/jquery.ajaxprefilter/
[Blank page]: https://en.wikipedia.org/wiki/About_URI_scheme
[Mocha]: https://mochajs.org/
[Solution based on custom types]: https://github.com/yiisoft/yii2/blob/37f19a02569833a9e49d2473439d9739444e78f8/tests/js/tests/yii.test.js#L981-L1026
[$.ajaxSetup]: https://api.jquery.com/jquery.ajaxsetup/
