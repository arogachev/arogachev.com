---
title: FT-Consult
site: http://fintechn.ru/
start_year: 2013
end_year: 2013
description: >
  "FT-Consult" is a russian company that specializes on supply, introduction and maintenance of information management 
  systems. Has 2 offices in Novosibirsk and Novokuznetsk.
technologies:
  - PHP
  - UMI.CMS
  - XSLT
  - MySQL
  - JavaScript
  - jQuery
screenshots: [home, menu, service, product, product_details, solutions, clients, contacts, presentation_request]
colors:
  background: 00a0e3
  font: fff
---

## Background

The site was developed during work at "INSY" company. One of the russian partner companies gave this project for
outsourcing.

## Development

UMI.CMS and XSLT were chosen as a content management system and used template engine accordingly.

Layout was implemented by specialists of the partner company, however, it was further customized according to customer's 
additional requiremenents.

### Representation of information

The site contains a big amount of hierarchical information with deep nesting level (some pages have 5th nesting level).
So it was important to provide tools for both better structuring and perception of information. Here are the elements 
and approaches that were used for it:

- Menu supporting up to 4 levels of nesting (introduction of bigger amount of levels would have a negative impact on 
UX).
- Content display with opportunity to see preview of child pages and go to their detail view.
- Breadcrumbs for quick view of parent pages and returning to them.

Back-end part of the site already contained necessary things for work with hierarchical data structures, available
through used CMS, so customizations were almost not needed.

### Features

Here is a brief list of site's other features:

- Products can be chosen by both name and scope of application.
- Key products were included in slider on main page which contained not only uploaded images but editable names, icons
and preview of product's description displayed on top of these images. Besides standard switches there is an additional 
block with names list.
- "Our clients" section allows to view the list of clients with grouping either by branch or first letter of the name. 
Alternative, more compact display mode in text list form is supported. Detailed description with list of implemented 
products and modules with links was added for each client.
- There is an opportunity of ordering presentation or receiving a consultation on any product. This functionality was 
implemented in a form of modal windows without page reload.

## Further development

The site still works. The customer was responsible in terms of filling of content and filled all existing site sections 
as much as possible. Key moments are being reflected in company's news.
