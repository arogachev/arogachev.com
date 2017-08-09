---
title: Psychological tests online
site: http://tests-psychology.com/
start_year: 2013
end_year: 2016
description: >
  Service providing a set of different psychological tests for passing online with automatic calculation of results.
technologies:
  - PHP
  - 1C-Bitrix
  - Yii
  - MySQL
  - JavaScript
  - jQuery
  - Bootstrap
  - Sass
screenshots: [home, menu, sign_up, tests, test, passing, saved_passings]
colors:
  background: 88cc19
  font: fff
---

## Background

A private psychologist reached out to "INSY" company with purpose of creating service of psychological tests for 
passing online. Despite the fact that similar services already existed (including the ones that are targeted at 
Russian-speaking audience), the customer wanted a project that distinguishes from competitors through the following 
factors:

- Colorful, attractive design. The customer noted that some of such services look very primitive like in the 90s.
= Total rejection of advertising on the site. According to the customer, some services. despite being pretty 
qualitative, were pushing users away with plenty of banners and advertising links.
- Make the process of passing as convenient as possible in terms of interface and usability. Test subject must not be
distracted by anything - neither by design nor by advertising nor by something else.
- Full automation of results' calculation.
- Availability of rare and complex tests.

## Phase 1 - Development in "INSY" company in "1C-Bitrix" CMS

The project development initially was being carried out in "INSY" company. The project was handed over to me for layout 
after design was implemented by the orher staff member.

### Layout

Because of unusual design, layout was not the most trivial task too. Non-standard elements and their alignment took more
time than usual. The tree is at the core of design:

- Tree crown is a header of the site. The fruits in the form of apples form main menu.
- Tree trunk contains the list of nested test categories. Upper level categories have thematic pictures for 
visualization.
- Footer duplicates site's main menu. This is convenient for quick navigation when scroll is closer to the bottom of the
page and acts as alternative for now popular button of fast return to the top of the site.

Of course, such design goes against the modern trends, furthermore it's not responsive and forces users to use zoom on 
mobile devices all the time. Nevertheless, the customer's requirement was met and he was pleased with the end result. In
addition, the site users also noted the originality of such approach.

### Programming

The management decided to use "1C-Bitrix" CMS for this project. It helped to speed up solving the tasks related with 
content and hierarchical structures but for key task - to organize filling and passing of tests of various types - 
proved to be virtually useless, given the specificity of subject area. That's why I had to implement this functionality
from scratch. After assessment of costs and complexity of customizations in back-end part and correlating them with 
project's budget and deadlines, the decision was taken to use XML for storing test's data. The customer approved this
option.

The automated calculation of the results was implemented but because of time and budget constraints, I was unable to 
make the passing process convenient, without page reload. It was planned to make the part of the tests private, with 
payment for getting access in order to obtain return from the site. Generally those are the most complex tests that can
not be found on the web, offering thorough analysis in certain problem. This functionality was also added, integration
with QIWI payment terminals and electronic wallets was carried out for online payments.

The site was launched and filling of content started. Unfortunately, the implemented algorithm did not cover all 
required types of tests since it was decided to add support of only basic and frequently used types at first. For adding
support of new types I had to constantly modify XML scheme retaining backwards compatibility. For particularly complex
tests it either took a long time or was not possible at all. Constantly increasing complexity of the scheme was also
making filling and editing of the tests even more uncomfortable for customer.

## Phase 2 - Transition to Yii Framework and further improvements

Later the customer contacted me and proposed to continue work on the project. At that time I was already working in 
"Fora" company but agreed to take the project as a side job.

### Design and layout customizations

Some design and layout related customizations had to be done in the first place according to new requirements of the
customer. The friends of mine - designer and HTML / CSS specialist were engaged for this purpose on an ad hoc basis and
the work was done. The appearance of modal window and new interface for passing test became one of the main innovations.
In addition to increasing convenience of use, another task - preventing distraction was solved through using darker
background. Some other details were added = for example, the owl waving a wing and switching random quotes of the famous
psychologists.

The decision about refusal to support older browsers (Internet Explorer 8, for example) was taken in the future and I
considerably simplified the layout by getting rid of a large amount of excess blocks and images. Further layout related
work were carried out on my own. A switch to SASS was done to simplify support of style sheets.

### Programming

Having assessed the complexity of further development of the project in "1C-Bitrix" CMS, I decided to rewrite it fully
in Yii Framework which I was studying at that time while working at "Fora" company. Test structure was redesigned using 
MVC framework models. It was decided to use expressions containing links to key objects, their values and also basic 
arithmetic and logic operations for calculation of the results. This list was subsequently supplemented by many other 
operations - for example, checking if one set is a subset of another set, etc. I excluded use of `eval` immediately for
security reasons. I wrote a custom component based on regular expressions because a suitable library for solving this 
task could not be found at that time.

The process of passing test was rewritten using JavaScript and jQuery to eliminate extra page reloads. The feature to
use only keyboard for navigation and answering the questions was added.

## Phase 3 - Transition to Yii 2 Framework and further improvements

At some point in "Fora" company we started to use second version of Yii since the first one inevitably became obsolete 
and was more difficult to support. Along with this I decided to upgrade "Psychological tests online" project to newer
version too. As it turned out - it was done for good reason. Work with project became easier and more productive. It 
was also a promising step in terms of future support. The code base was not so huge yet and migration process was 
completed pretty quickly.

### Integration of third-party library for expressions

At this stage, a third-party library compiling and evaluating expressions for calculation of the results was found. It
turned out to be more flexible and extensible, that's why I integrated it and removed my own groundwork. The calculation
algorithm based on expressions was suitable for all types of tests.

### Organizing convenient filling of tests

The next important step was creating convenient tools for filling data. Usually, a test contained a large amount of 
hierarchical and related objects. Using web interface was taking much time and was not providing the right level of ease
of use. The customer also expressed the wish about using Excel. The problem was solved by writing 
[yii2-excel][yii2-excel] component. Its source code is available on Github, the list of import features can be viewed in
documentation to [Basic import][yii2-excel Basic import] and [Advanced import][yii2-excel Advanced import] sections.

Excel tables were used for initial import but web interface could also be used as an alternative option. For convenient 
creation and further editing of test's constituent elements it was considerably redesigned - the hierarchy of objects 
was highlighted, grouping of related data was introduced, navigation was improved.

Content managers were additionally recruited to fill tests later. Access permissions were adjusted accordingly.

### Other customizations

A number of other customizations were made:

- The feature of using access codes for free passing of private tests for a limited period of time was added.
- In addition to conclusions of the test's author, the comments of psychologist, information about related tests and
ongoing trainings, recommendations to sign up for consultation can now be included in the final output at the 
appropriate place.
- The functionality of saving and repeated viewing of passed tests' results was added.

The test list page was also redesigned:

- Filters including editable set of properties were added.
- Masonry library was plugged in to form a grid of blocks with different content size and optimal use of existing space.

The build system of project's JS and CSS dependencies was improved using Grunt, deploy on the production server was set
up using Deployer.

## Further development

The project was focused on a wide audience and had great potential. The development was quite slow because I was the
only one engaged in it and did not have much spare time. Development and implementation of test structure, component 
calculating the results along with their adaptation to all types of tests (new requirements were being found out as work 
progressed) were particularly time-consuming. As for the customer, it was an experimental project, which he was also 
doing in addition to day job. The involvement of more people was not possible due to the lack of additional financing 
and investment.

At some point it turned out that profit making strategy proved to be a failure. Work on project was suspended at the 
initiative of the customer. Further filling of content is also not made. After that, financial strategy was reconsidered
and all efforts were aimed at creating new project - [Tests-Psychology Corp][Tests-Psychology Corp], based on existing 
core.

For me it was the most extensive project that I worked on in parallel with main job. Despite the fact that it's on hold
now, I got a good experience of solving complex practical tasks.

[yii2-excel]: https://github.com/arogachev/yii2-excel
[yii2-excel Basic import]: https://github.com/arogachev/yii2-excel/blob/master/docs/import-basic.md
[yii2-excel Advanced import]: https://github.com/arogachev/yii2-excel/blob/master/docs/import-advanced.md
[Tests-Psychology Corp]: /portfolio/tests-psychology-corp/
