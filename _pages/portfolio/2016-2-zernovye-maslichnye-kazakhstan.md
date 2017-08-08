---
title: Zernovye & Maslichnye. Kazakhstan
site: https://margin.kz/
start_year: 2016
end_year:
description: Informational and analytical resource about grain and oil-bearing crops in Kazakhstan.
technologies:
  - Python
  - Django
  - PostgreSQL
  - JavaScript
  - jQuery
  - Bootstrap
  - Sass
screenshots: [home, news, agrarian_map, trading_platform, adding_enterprise]
colors:
  background: ee7e18
  font: fff
---

## Background

The project initially was planned as side job while working at "Fora" company. "Zernovye & Maslichnye. Kazakhstan" 
information and analysis bureau already had site written in Joomla, however the leader was not satisfied with its work 
and support. Moreover, a multitude of improvements that made the using CMS of this kind inappropriate were being 
planned. The key idea from business point of view was opportunity of closing of specific content parts from common 
access and introduction of paid subscriptions for viewing them.

Probably I wouldn't take this project, but I thought that it's a good opportunity to learn something new from 
programming languages ahd technologies in parallel and move forward without limiting myself to PHP + MySQL stack. I 
chose Python and Django in combination with PostgreSQL. Having estimated the scope of work and considered some other 
circumstances I made a decision about leaving previous work to devote all working time to development of this project.

## Design and layout

Along with moving to other platform, the decision about site's redesign was taken. My colleague from previous job was
involved for doing design and layout.

After approval of design by the customer, further layout related work was being carried out on my own:

- Fixing the bugs in original templates.
- Design of new blocks and pages.
- Using Bootstrap for forms and notifications (both static and pop-up).
- Layout for emails for mailings.

## News

This module already existed on original site, its customization was required. From the innovations I can highlight 
these:

- The cropping of the main image based on aspect ratio to form a flat grid in news list was implemented. 
- The search by tags was added.
- It's now possible to emphasize separate news by fixing them at the top of the list as well as marking them as 
promotional.  
- Templates for convenient use of frequently repeating text parts were added.
- The feature of news' deactivation was added.
- "Disqus" comments were connected, necessary settings for correct publication of news on Facebook were implemented.
- Human readable URLs for categories and news were set up - and linking with id is used for news, so name with slug can 
be edited at any moment after news' publication.
- The feature of including private paid content in author's news was added.

### Related customizations

Besides the news these modules and features were added at this stage:

- Information pages, like in CMS, with visual editor, feature of uploading images and other files.
- The feature of inserting advertising banners.
- Charts with feature of importing data from Excel and subsequent fixing in site's right column or linking to one of the
news categories.
- Registration and login with feature of using social services - Twitter, Google, Facebook, VKontakte; account for 
users.

The transfer of content and files from the old site was done, also basic SEO activities including the setting of 
redirects with regard to changes in links structure were carried out.

The site was launched in late May 2016.

### Further customizations

Later Highcharts library was added for working with charts, the integration with CKEditor was carried out.

## Agrarian map

Agrarian map of Kazakhstan is a new innovative module, which, according to the customer, has no parallel in Kazakhstan.
The feature to form the base of agricultural enterprises of Kazakhstan with convenient viewing of their location on the 
map was implemented:

- For linking with geographical data "Geography" module with division into regions, districts and settlements was added. 
- The filter for quick search of enterprises group of specific enterprise was added.
- The map with grouping of enterprises into settlements, clustering of all markers (for ease of perception and fast 
loading) and synchronization with filter was implemented.
- Users can participate in filling of the enteprises base, assign themselves to the selected enterprise. 
- A convenient way of choosing enterprise's location using map was added.
- Part of the enterprise's information is now closed from common access and provided on a paid basis.

Any addition or change of enterprise is moderated:

- Deactivation of an enterprise for a period of moderation.
- There is a feature of viewing the exact fields and content parts that were changed with visual highlighting of old and
new values.
- The opportunity to engage in dialogue about filled oject for both user and site administrator: for user - to ask 
clarifying questions, for administrator - to answer them or request corrections.
- Saving history of changes and feature to rollback to previous version.
- Notifications for administrator and user about the need for making changes. 

### Further customizations

The feature of viewing enterprises next to selected enterprise / settlement within a certain radius was subsequently
added. For this functionality PostGIS was plugged in and migration of geographical coordinates was done.

## Trading platform

This is one more new module for publishing and viewing advertisements about buying and selling crops. What makes it 
different from similar bulletin boards in the first place is the fact that advertisement can be added on behalf of the 
enterprise only and more thorough verification which reduces the likelihood of actions by unauthorized persons 
considerably.

Link with enterprise also:

- Contributes to filling of the enterprises base.
- Helps to get more information about sellers / buyers and see their location.

Implemented functionality also includes:

- The filter by main criterias was added.
- The moderation system similar to used for enterprises was added.
- The opportunity of filling a complaint against advertisement was added. All complaints are moderated with further
informing the users.
- Quantitative and time limitations for adding advertisement are reflected in user's permissions.
- Part of the advertisement's information is with restricted access and provided for a fee.

## Subscription

Before creation of this module the assignment of groups with corresponding set of permissions to user was used for 
providing paid services. Besides the manual setup, it was also necessary to unset the group at the right time for 
subscription's deactivation. Obviously that with growth of orders' number such approach was making work with clients 
very difficult. The decision about creating full-fledged e-commerce platform was taken.

### Modular subscriptions

Subscriptions with sets of permissions opening functionality within a certain module and also with full access were 
formed. Time limit by period of validity - from 1 month to 1 year was introduced.

### Subscriptions to objects

After examination of the demand it has become known that not all clients require modular subscriptions - there are those
among them who, for example, need full access to the one specific enterprise. Subscription to objects that are available 
indefinitely were introduced accordingly. The implementation excludes the need for creating separate products for online 
shop.
 
### Features

In addition the following features were implemented:

- Combining and prolongating subscriptions.
- Trial period during which users can try and access paid functionality of the site for free.
- Forming the order by administrator with reworked interface for support of both subscription's types was added for 
exceptional cases. There is also a feature of creating order retroactively mainly needed for transfer of subscriptions
created earlier via assigning groups to users manually.
- Payment through credit cards (VISA, MasterCard) with instant activation of selected services.

## Miscellaneous innovations

From the other innovations I would like to point out these:

- Besides Disqus, other third-party services - for notifications and also for feedback and ideas of the users were 
involved.
= Introduction of notifications (static, pop-up, email, web push) for alerts for informing about the results of actions
/ object statuses.
- CSS and JS dependencies were optimized using Django Compressor, including administrative part.

Some JS plugins were developed:

- The form with client validation and submitting via AJAX feature.
- The dependent drop-down lists plugin with support of simultaneous updating of multiple dependent drop-down lists.
- Replaced block with use of pjax.

## Further development

The site is being actively developed, the number of users and subscribers is increasing. There is a development of new
module in the plans.
