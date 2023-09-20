---

layout: default
title: Minutes
group: "navigation"
root: ../
---

### Minutes of the NAACL Board Meetings

<ul>
{% for year in (2000..2023) reversed %}

<li>
<a href="{{ site.baseurl }}/minutes/{{ year }}/index.html">Minutes from {{ year }}</a>

</li>
{% endfor %}

</ul>

