# {{ basics.name }}

![](assets/images/resume/main_photo.jpg){width=150px height=150px}

{{ basics.specialization }}, {{ basics.age }} years old

**Experience:** {{ basics.work_duration.label }} in total

**Location:** {{ basics.location.city }}, {{ basics.location.country }} ({{ basics.location.region }})

**Languages:**

{% for language in basics.languages %}
- {{ language.name }} ({{ language.level }})
{% endfor %}

{{ basics.summary }}

## Work

{% for job in work_reversed %}
### {{ job.company }} ({{ job.start_date_year }} - {{ job.end_date_year }})

**Period:** {{ job.start_date_text }} - {{ job.end_date_text }} (**{{ job.work_duration.label }}** in total)

**Position:** {{ job.position }}

**Website:** [{{ job.website }}]({{ job.website }})

{{ job.summary }}

**Technologies:** {{ job.technologies | sentence }}

**Tasks:**

{% for task in job.tasks %}
- {{ task }}
{% endfor %}

**Highlights:**

{% for highlight in job.highlights %}
- {{ highlight }}
{% endfor %}

**Results:**

{% for result in job.results %}
- {{ result }}
{% endfor %}

**Achievements:**

{% for achievement in job.achievements %}
- {{ achievement }}
{% endfor %}

{% endfor %}

## Education

**Period:** {{ education.start_date_text }} - {{ education.end_date_text }}

**Institution:** {{ education.institution }}

**Area:** {{ education.area }}

**Degree:** {{ education.degree }}

**GPA:** {{ education.gpa }}

**Courses:**

{% for course in education.courses %}
- {{ course }}
{% endfor %}

## Skills

{% for skill in skills %}
**{{ skill.name }}:** {{ skill.keywords | sentence }}

{% endfor %}

## Extra activity

{% for action in activity %}
- {{ action }}
{% endfor %}

## References

{% for reference in references %}
"{{ reference.text }}"

*{{ reference.author_text }}*

{% endfor %}

## Interests

{% for interest in interests %}
- {{ interest.name }}{% unless interest.keywords == empty %} ({{ interest.keywords | sentence }}){% endunless %}

{% endfor %}

## Profiles

{% for profile_data in profiles %}
{% assign profile = profile_data[1] %}
**{{ profile.network }}:** [{{ profile.url }}]({{ profile.url }})

{% endfor %}
