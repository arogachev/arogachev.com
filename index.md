---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
title: Alexey Rogachev's personal website
---

{% assign latest_posts=site.posts | latest_posts: 5 %}

## Latest blog posts
{% include blog/posts.html posts=latest_posts %}
