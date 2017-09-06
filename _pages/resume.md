---
layout: resume
title: Resume
permalink: /resume/
menu_item: resume
heading_icon: folder-open
content_class: resume
---

{% assign resume = site.data.resume %}

{% include resume/basics.html %}

## About
{% include resume/about.html %}

## Work
{% include resume/work.html %}

## Education
{% include resume/education.html %}

## Skills
{% include resume/skills.html %}

## Extra activity
{% include resume/activity.html %}

## References
{% include resume/references.html %}

## Interests
{% include resume/interests.html %}
