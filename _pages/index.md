---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
title: Alexey Rogachev's personal website
permalink: /
content_class: home
---

{% assign home = site.data.home %}
{% assign geo = site.data.geo %}
{% assign resume = site.data.resume %}
{% assign latest_references = resume.references | latest_items: 2 %}

{% include home/basic_info.html %}
{% include home/feed.html %}
{% include home/grouped_info.html %}

# What people talk about me
{% include home/references.html references=latest_references %}
