# {{ basics.name }}

![](assets/images/resume/main_photo.jpg){width=150px height=150px}

{{ basics.specialization }}, {{ basics.age }} years old

**Location:** {{ basics.location.city }}, {{ basics.location.country }} ({{ basics.location.region }})

**Experience:** {{ basics.work_duration.label }}

## About

{{ basics.summary }}

**Languages:**

{% for language in basics.languages %}
- {{ language.name }}: ILR - {{ language.level.ilr }}, CEFR - {{ language.level.cefr }}
{% endfor %}

## Work

{% for job in work_reversed %}
### {{ job.name }} ({{ job.start_date_year }} - {{ job.end_date_year }})

{% if job.location %}
**Location**: {{ job.location.city }}, {{ job.location.country }}
{% else %}
**Location**: Remote
{% endif %}

**Period:** {{ job.start_date_text }} - {{ job.end_date_text }} (**{{ job.work_duration.label }}**)

{{ job.summary }}

{% if job.legal_name %}
**Legal name:** {{ job.legal_name }}
{% endif %}

**Website:** [{{ job.website }}]({{ job.website }})

**Position:** {{ job.position }}

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

**Diploma with honours**

**Courses:**

{% for course in education.courses %}
- {{ course.code }} - {{ course.name }}
{% endfor %}

## Skills

{% for skill in skills.all %}
**{{ skill.name }}:** {{ skill.keywords | sentence }}

{% endfor %}

## Extra activity

{% for action in activity %}
- {{ action }}
{% endfor %}

## References

{% for reference in references %}
{% capture author_position %}
  {% if reference.position %}{{ reference.position }}{% endif %}
  {% if reference.company %}
    {{ reference.preposition }}
    [{{ reference.company.name }}]({{ reference.company.link }})
  {% endif %}
{% endcapture %}

"{{ reference.text }}"

*[{{ reference.author.name }}]({{ reference.author.link }}), {{ author_position }}*

{% endfor %}

## Interests

{% for interest in interests %}
- {{ interest.name }}{% unless details == empty %} ({{ interest.details | map: 'name' | sentence }}){% endunless %}

{% endfor %}

## Profiles

{% for profile_data in profiles %}
{% assign profile = profile_data[1] %}
**{{ profile.network }}:** [{{ profile.url }}]({{ profile.url }})

{% endfor %}
