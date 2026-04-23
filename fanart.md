---
layout: page
title: ファンアート
permalink: /fanart/
---

{% assign now_timestamp = site.time | date: "%s" %}
{% assign fanart_posts = site.data.fanart_posts | sort: "posted_at" | reverse %}
{% assign visible_count = 0 %}

<div class="fanart-list">
  {% for post in fanart_posts %}
    {% assign expires_timestamp = post.expires_at | date: "%s" %}
    {% if expires_timestamp >= now_timestamp %}
      {% assign visible_count = visible_count | plus: 1 %}
      <article class="fanart-post">
        {{ post.embed_html }}
      </article>
    {% endif %}
  {% endfor %}
</div>

{% if visible_count == 0 %}
  <p class="fanart-empty">現在表示できる投稿はありません。</p>
{% else %}
  <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
{% endif %}
