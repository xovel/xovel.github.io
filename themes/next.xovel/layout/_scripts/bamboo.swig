{% if page.bamboo %}
{% set toc = toc(page.content,{"class": "bamboo-toc",list_number: page.number}) %}
<style type="text/css">
.bamboo-box{background:#f7f7f7;margin-bottom:20px; position:relative;}
.bamboo-box:before{ content:'目录'; font-size:12px; position:absolute; right:5px; top:5px; line-height:15px; font-weight:bold; padding:0 5px; border-bottom:1px solid #ccc;}
.bamboo-toc{ list-style: none; margin-top:0px; padding-top:10px; padding-left:15px;}
.bamboo-toc ol{ padding-left:2em;}
.bamboo-toc li{ list-style:none;}
{% if page.liststyle %}
ul li{ list-style:{{ page.liststyle }};}
{% endif %}  
</style>
<div class="bamboo-box">
{{ toc }}
<div style="height:5px;width:100%;background-color:#258207;border-radius:5px;"></div>
</div>
{% endif %}