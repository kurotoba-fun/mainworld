---
layout: page
title: ギャラリー
permalink: /gallery/
---

<p class="lead">画像をクリックするとモーダルで拡大表示されます。</p>

<div class="gallery-toolbar">
  <span class="gallery-toolbar-label">表示</span>
  <div class="gallery-toggle" role="group" aria-label="ギャラリー表示切り替え">
    <button class="gallery-toggle-button" type="button" data-gallery-view="cards" aria-pressed="true">カード</button>
    <button class="gallery-toggle-button" type="button" data-gallery-view="photos" aria-pressed="false">写真</button>
  </div>
</div>

{% assign gallery_items = site.data.gallery_items | sort: "date" | reverse %}

<section class="gallery-grid" data-gallery-view="cards">
  {% for item in gallery_items %}
    {% assign thumb_src = item.src %}
    {% if item.src contains '.jpg' %}
      {% assign thumb_src = item.src | replace: '.jpg', '.webp' %}
    {% elsif item.src contains '.JPG' %}
      {% assign thumb_src = item.src | replace: '.JPG', '.webp' %}
    {% elsif item.src contains '.jpeg' %}
      {% assign thumb_src = item.src | replace: '.jpeg', '.webp' %}
    {% elsif item.src contains '.JPEG' %}
      {% assign thumb_src = item.src | replace: '.JPEG', '.webp' %}
    {% elsif item.src contains '.png' %}
      {% assign thumb_src = item.src | replace: '.png', '.webp' %}
    {% elsif item.src contains '.PNG' %}
      {% assign thumb_src = item.src | replace: '.PNG', '.webp' %}
    {% endif %}
    {% assign webp_match = site.static_files | where: "relative_path", thumb_src %}
    <figure class="gallery-card">
      <button class="gallery-link" type="button" data-gallery-src="{{ item.src | relative_url }}" data-gallery-title="{{ item.title }}">
        <picture>
          {% if webp_match and webp_match.size > 0 %}
            <source data-srcset="{{ thumb_src | relative_url }}" type="image/webp">
          {% endif %}
          <img
            src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
            data-src="{{ item.src | relative_url }}"
            alt="{{ item.title | default: 'gallery image' }}"
            loading="lazy"
          >
        </picture>
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

    var viewContainer = document.querySelector('.gallery-grid');
    var toggleButtons = Array.prototype.slice.call(document.querySelectorAll('.gallery-toggle-button'));
    var setView = function (view) {
      if (!viewContainer) return;
      viewContainer.setAttribute('data-gallery-view', view);
      toggleButtons.forEach(function (button) {
        var isActive = button.getAttribute('data-gallery-view') === view;
        button.setAttribute('aria-pressed', String(isActive));
      });
      try {
        window.localStorage.setItem('galleryView', view);
      } catch (e) {}
    };

    var preferred = null;
    try {
      preferred = window.localStorage.getItem('galleryView');
    } catch (e) {}
    if (!preferred) {
      preferred = window.matchMedia('(max-width: 640px)').matches ? 'photos' : 'cards';
    }
    setView(preferred);

    toggleButtons.forEach(function (button) {
      button.addEventListener('click', function () {
        setView(button.getAttribute('data-gallery-view'));
      });
    });

    var lazyTargets = Array.prototype.slice.call(document.querySelectorAll('.gallery-grid img[data-src]'));
    if ('IntersectionObserver' in window) {
      var observer = new IntersectionObserver(function (entries, obs) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) return;
          var img = entry.target;
          var picture = img.closest('picture');
          if (picture) {
            picture.querySelectorAll('source[data-srcset]').forEach(function (source) {
              source.srcset = source.getAttribute('data-srcset');
              source.removeAttribute('data-srcset');
            });
          }
          img.src = img.getAttribute('data-src');
          img.removeAttribute('data-src');
          obs.unobserve(img);
        });
      }, { rootMargin: '200px 0px' });
      lazyTargets.forEach(function (img) { observer.observe(img); });
    } else {
      lazyTargets.forEach(function (img) {
        img.src = img.getAttribute('data-src');
        img.removeAttribute('data-src');
      });
    }
  })();
</script>
