---
title: Job in FORA company
start_year: 2014
end_year: 2016
description: Separate service for jobs in FORA company.
technologies: [PHP, Yii, MySQL, JavaScript, jQuery, Bootstrap, Sass]
  
site: http://job.fora.kz/
status: working
company: FORA

screenshots: [home, vacancies, vacancy, career, resume_constructor]
colors:
  background: cc2128
  font: f5f6f7
---

## Background

Before appearance of this project there was a separate "Jobs" section on ["FORA"][FORA] company's main site where users 
could view the list of actual jobs and respond to suitable one. In turn HR department specialists had access to 
corresponding section of administrative site's part for viewing received responses. However over time this functionality 
became insufficient in both administrative and public parts of the site. Because jobs part was not coupled neither with 
product nor other components of online shop, and code base continued growing considerably, the decision was taken to 
move this functionality to separate project.

The project was developed in Yii 2 PHP framework with use of MySQL RDBMS.

## New features and benefits

### For candidates

From appeared innovations in public part these are worth mentioning:

- Structurization of jobs and introduction of filters allowed to find job quicker according to required city and 
knowledge / skills area.
- The resume constructor allowing quicker creation of the resume from scratch appeared. As practice shows, many 
candidates still have difficulties with it, especially representatives of non-technical specialities. Besides that
constructor sets own standard and takes away candidate's extra doubts about incorrect design etc.
- The contents improved - more information about company and its employees, answers to frequently asked questions became 
available.

### For employees

The project promoted automation and optimization of HR department work in all company's branches:

- Improved permission system allowed specialists to work with jobs according to their position and geographic location.
- Maintaining the account on each candidate, carrying out planning, filling of schedule and interview results became 
possible.
- Communication system for employees from different branches and with different positions was improved. The decisions
about taking candidate to staff or refusal began to be made quicker.
- Notifications reduced employees' reaction time to sent resume and other events in the system.
- The feature to respond candidate directly from the site with use of different templates appeared.

One more important plus of creating this project is a disposal from legacy code and simplification of its support. The
main site was still written in Yii 1 which became strongly outdated even at that time.

## Further development

After collective work and project's launch, its further development and support was fully delegated to me. Besides
technical aspect, the active communication directly with HR department main specialist was occuring, during which the 
bugs and the new tasks were being discussed and consultations about system's work were being given.

[FORA]: https://fora.kz/
