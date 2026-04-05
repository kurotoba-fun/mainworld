---
layout: page
title: 学園パロディ キャラクター一覧
lead: 黒帳学園に登場するキャラクターの一覧です。気になる人物を選ぶと詳細ページへ移動します。
permalink: /academy/characters/
theme: academy
---

<div class="card-grid">
  {% assign sorted_characters = site.academy_characters | sort: 'order' %}
  {% for character in sorted_characters %}
    {% include character-card.html character=character %}
  {% endfor %}
</div>