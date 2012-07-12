naacl-org.github.com
================

new NAACL website using Jekyll and github hosting

contact Anoop Sarkar for details

Links under Navigation side bar
-------------------

1. The basic layout of the site is defined in _layouts/default.html
2. The Navigation side bar is generated using the following code in default.html:
              <li class="nav-header">Navigation</li>
              {% assign pages_list = site.pages %}
              {% assign group = 'navigation' %}
              {% include pages_list %}
3. All pages which have 'group: "navigation"' included in their header information (see, e.g., about/index.textile) are automatically included in the above Navigation links for the website.

Adding a new set of Officers
-----------------

1. Copy the previous years officers file to the new year, e.g. copy officers-2012.textile to officers-2013.textile
2. Edit the previous year file to remove the line 'group: "navigation"', e.g. remove this line from officers-2012.textile
3. Keep the line 'group: "navigation"' in the new file, e.g. keep this line in officers-2013.textile
4. The list of previous years for all the officers is stored in the file _includes/officers_year_list -- Change this file to add the new year.
5. If the number of years grows too large, edit the file _includes/officers_year_list to add a limit: change '{% for year in (2000..2012) %}' to '{% for year in (2000..2012) limit:5 %}'

Changing index.html
-------------------

1. The central view of index.html is a div called the "hero" unit
2. To advertise an upcoming conference you can copy and use the NAACL 2012 hero unit in _includes/naacl2012_hero_div
3. To use the NAACL poster image instead you can copy and use the default hero unit in _includes/default_hero_div

