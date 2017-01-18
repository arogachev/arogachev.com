# {{ basics.name }}

![](assets/images/resume/main_photo.jpg){width=150px height=150px}

{{ basics.specialization }}, {{ basics.age }} years old

**Experience:** {{ basics.work_duration }} in total

**Location:** {{ basics.location.city }}, {{ basics.location.country }} ({{ basics.location.region }})

**Languages:**

{% for language in basics.languages %}
- {{ language.name }} ({{ language.level }})
{% endfor %}

{{ basics.summary }}

## Work

{% for job in work_reversed %}
### {{ job.company }} ({{ job.start_date_year }} - {{ job.end_date_year }})

**Period:** {{ job.start_date_text }} - {{ job.end_date_text }} (**{{ job.work_duration }}** in total)

**Position:** {{ job.position }}

**Website:** [{{ job.website }}]({{ job.website }})

{{ job.summary }}

{% endfor %}
