---
layout: page
title: キャラクター一覧
lead: 黒帳に登場するキャラクターの一覧です。気になる人物を選ぶと詳細ページへ移動します。
permalink: /characters/
---

<div class="card-grid">
  {% assign sorted_characters = site.characters | sort: 'order' %}
  {% for character in sorted_characters %}
    {% include character-card.html character=character %}
  {% endfor %}
</div>
