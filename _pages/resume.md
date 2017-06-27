---
layout: default
title: Resume
permalink: /resume/
content_class: resume anchored
---

{% assign resume = site.data.resume %}

{% include resume/basics.html %}
{% include resume/download.html %}

## Work
{% include resume/work.html %}

## Education
{% include resume/education.html %}

## Skills
{% include resume/skills.html %}

## Extra activity
{% include resume/activity.html %}

## References
{% include resume/references.html references=resume.references %}

## Interests
{% include resume/interests.html %}

## Profiles
{% include resume/profiles.html %}
