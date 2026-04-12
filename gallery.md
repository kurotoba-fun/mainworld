---
layout: page
title: ギャラリー
permalink: /gallery/
items:
  - src: /assets/images/gallery/amagi1.jpg
    title: "ヘアチェンジ天城"
    tags: ["天城","ヘアチェンジ"]
  - src: /assets/images/gallery/shirabe1.jpg
    title: "ヘアピン調"
    tags: ["調"]
  - src: /assets/images/gallery/shirabe2.jpg
    title: "幼い調"
    tags: ["調"]
  - src: /assets/images/gallery/sirose1.jpg
    title: "ホストヘア白瀬"
    tags: ["白瀬"]
---

<p class="lead">画像をクリックするとモーダルで拡大表示されます。タグはこのページの `items` に追加してください。</p>

<section class="gallery-grid">
  {% for item in page.items %}
    <figure class="gallery-card">
      <button class="gallery-link" type="button" data-gallery-src="{{ item.src | relative_url }}" data-gallery-title="{{ item.title }}">
        <img
          src="{{ item.src | relative_url }}"
          alt="{{ item.title | default: 'gallery image' }}"
          loading="lazy"
        >
      </button>
      {% if item.title or item.tags %}
        <figcaption class="gallery-caption">
          {% if item.title %}
            <p class="gallery-title">{{ item.title }}</p>
          {% endif %}
          {% if item.tags %}
            <div class="gallery-tags">
              {% for tag in item.tags %}
                <span class="gallery-tag">{{ tag }}</span>
              {% endfor %}
            </div>
          {% endif %}
        </figcaption>
      {% endif %}
    </figure>
  {% endfor %}
</section>

<div class="gallery-modal" id="gallery-modal" aria-hidden="true">
  <div class="gallery-modal-backdrop" data-gallery-close></div>
  <div class="gallery-modal-dialog" role="dialog" aria-modal="true" aria-labelledby="gallery-modal-title">
    <button class="gallery-modal-close" type="button" aria-label="閉じる" data-gallery-close>×</button>
    <img class="gallery-modal-image" src="" alt="" id="gallery-modal-image">
    <p class="gallery-modal-title" id="gallery-modal-title"></p>
  </div>
</div>

<script>
  (function () {
    var gallery = document.querySelector('.gallery-grid');
    var modal = document.getElementById('gallery-modal');
    var modalImage = document.getElementById('gallery-modal-image');
    var modalTitle = document.getElementById('gallery-modal-title');
    if (!gallery || !modal || !modalImage) return;

    var openModal = function (src, title) {
      modalImage.src = src;
      modalImage.alt = title || 'gallery image';
      modalTitle.textContent = title || '';
      modal.setAttribute('aria-hidden', 'false');
      document.body.classList.add('is-gallery-modal-open');
    };

    var closeModal = function () {
      modal.setAttribute('aria-hidden', 'true');
      modalImage.src = '';
      modalTitle.textContent = '';
      document.body.classList.remove('is-gallery-modal-open');
    };

    gallery.addEventListener('click', function (event) {
      var trigger = event.target.closest('.gallery-link');
      if (!trigger) return;
      var src = trigger.getAttribute('data-gallery-src');
      var title = trigger.getAttribute('data-gallery-title');
      if (!src) return;
      openModal(src, title);
    });

    modal.addEventListener('click', function (event) {
      if (event.target.closest('[data-gallery-close]')) {
        closeModal();
      }
    });

    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && modal.getAttribute('aria-hidden') === 'false') {
        closeModal();
      }
    });
  })();
</script>
