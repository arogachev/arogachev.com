{% capture location %}
{{ basics.location.city }}, {{ basics.location.country }} ({{ basics.location.region }})
{% if secrets %} | {{ secrets.zip_code }}, {{ secrets.address }}{% endif %}
{% endcapture %}

{% capture email %}[{{basics.email}}](mailto:{{basics.email}}){% endcapture %}
{% if secrets %}{% capture phone %}{{ secrets.phone }}{% endcapture %}{% endif %}
{% capture site %}[{{ basics.site.name }}]({{ basics.site.url }}){% endcapture %}
{% capture github %}{{ profiles.github | profile_link }}{% endcapture %}
{% capture linkedin %}{{ profiles.linkedin | profile_link }}{% endcapture %}
{% capture contacts %}
{{ email }} {% if phone %}| {{ phone }}{% endif %} | {{ site }} | {{ github }} | {{ linkedin }}
{% endcapture %}

# {{ basics.name }}

*{{ basics.specialization }}*

![](assets/images/resume/main_photo.jpg){width=100px height=100px}

{{ location }}

{{ contacts }}

## Work

{% for job in work_reversed %}
### {{ job.company }}, {{ job.position | downcase }} ({{ job.start_date_text }} - {{ job.end_date_text }})

{% for highlight in job.brief_highlights %}
- {{ highlight | brief }}
{% endfor %}

{% endfor %}

## Education

### {{ education.institution }} ({{ education.start_date_text }} - {{ education.end_date_text }})  

{{ education.area }} | {{ education.degree }} degree | {{ education.gpa }} GPA | {{ education.highlights | sentence }}

## Extra activity

{% for action in activity %}
- {{ action }}
{% endfor %}
