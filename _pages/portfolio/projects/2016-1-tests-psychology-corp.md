---
title: Tests-Psychology Corp
site: http://corp.tests-psychology.com/
year: 2016
description: Extension of "Psychological tests online" project focused on corporate clients.
technologies:
  - PHP
  - Yii
  - MySQL
  - JavaScript
  - jQuery
  - Bootstrap
  - Sass
screenshots: [home, passing, results]
---

## Background

This site is a logical extension of ["Psychological tests online"][Psychological tests online] project. Having realized
that making profit through selling separate tests is complicated the customer decided to create separate service focused
not on wide audience but on corporate clients. These organizations were primarily being considered as such clients:

- The schools where testing is either mandatory part of the educational program or tool helping psychologists to better
understand the problems of certain children.
- Private organizations where testing can be used for selection of staff.

## Development

We had to abandon the idea to use existing site because laconic and strict design without extra sections was needed for
corporate clients. Inside the existing project a separate application for working with tests using existing 
functionality was created.

### New objects

First of all, new key objects were added to the system:

- Organizations and their representatives (usually psychologists).
- Test subjects with feature of grouping. One test subject could belong to multiple groups at once - for example, to
group of own class and to group with increased level of anxiety.

Component of import via Excel was complemented by new types for fast filling.

### Tests

The feature of separation of the tests for corporate sector from a common set appeared. 

Organizations receive own tests set according to subscription. After expiration of subscription the access to tests is
blocked for both representatives of organization and persons getting tested.

Representatives of organizations received an opportunity to work with site according to their permissions. The feature
to quickly fill data via Excel according to their organization was also provided for them.

A test can be appointed for passing to both group of test subjects and certain person. Test's availability is also
determined by set time period. Support of different time zones was added.

### Testing

It was required that testing process must be as simple as possible - it must exclude registration and other complicated
actions because the service can be used by children. For identification of test subjects access code system was 
introduced. These codes are created and managed by organization's representatives.

There is a feature to extend the group of test subjects without participation of organization's representative - new 
test subject can join chosen group before the testing.

The interface was implemented by analogy with main site but with some customizations and use of Bootstrap.

The test results can be hidden from test subject, but they are fully available for responsible psychologists. There is a
feature of export to Word document to form reporting.

### Multiple languages support

One more innovation was multiple language support. There are some schools among local educational institutions where a
training programme is conducted in Kazakh, also attracting of other foreign clients was being planned for the future.
Corresponding changes were implemented:

- In administrative part of the site it's now possible to add a translation in other language for each component of the 
test.
- During filling the data for initial import of the test via Excel translations can be filled next to original text 
which is more convenient.
- Test subjects can now select language before passing of the test and testing will be carried out in selected language.

## Further development

After implementing of main required functionality introduction of the project in one of local schools with education in
Kazakh started. Convenience of working with service was appreciated by clients, further customizations were carried out
based on their criticism and suggestions. Later service also became operational in a number of Kazakh and Russian 
schools. Similar products generally were implemented in form of window applications and lacked support of different 
languages and other features.

Despite quite good development prospects, later financing of the project was stopped and work on it was discontinued.

[Psychological tests online]: /portfolio/projects/psychological-tests-online/
