# {{ basics.name }}

![](assets/images/resume/main_photo.jpg){width=150px height=150px}

{% capture location %}
{{ basics.location.city }}, {{ basics.location.country }} ({{ basics.location.region }})
{% endcapture %}

{{ basics.specialization }} | {{ location }}

## Work

{% for job in work_reversed %}
### {{ job.company }} ({{ job.start_date_text }} - {{ job.end_date_text }})

*{{ job.position }}*

{% for highlight in job.brief_highlights %}
- {{ highlight | brief }}
{% endfor %}

{% endfor %}
