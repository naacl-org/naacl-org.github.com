naacl-org.github.com
================

new NAACL website using Jekyll and github pages hosting

contact Anoop Sarkar for details

Adding a new set of Officers
-----------------

1. Copy the previous years officers file to the new year, e.g. copy officers-2012.textile to officers-2013.textile
2. Edit the previous year file to remove the line 'group: "navigation"', e.g. remove this line from officers-2012.textile
3. Keep the line 'group: "navigation"' in the new file, e.g. keep this line in officers-2013.textile
4. The list of previous years for all the officers is stored in the file _includes/officers_year_list -- Change this file to add the new year.
5. If the number of years grows too large, edit the file _includes/officers_year_list to add a limit: change '{% for year in (2000..2012) %}' to '{% for year in (2000..2012) limit:5 %}'


