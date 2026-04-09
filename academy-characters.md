---
layout: page
title: キャラクター一覧
display_title: CHARACTERS
title_label: 学園パロディ
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
