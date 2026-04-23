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
      <article class="fanart-post" data-fanart-post>
        <div class="fanart-embed" data-fanart-embed>
          <template data-fanart-template>
            {{ post.embed_html }}
          </template>
          <p class="fanart-loading">読み込み中...</p>
        </div>
      </article>
    {% endif %}
  {% endfor %}
</div>

{% if visible_count == 0 %}
  <p class="fanart-empty">現在表示できる投稿はありません。</p>
{% else %}
  <script>
    (function () {
      var posts = Array.prototype.slice.call(document.querySelectorAll('[data-fanart-post]'));
      if (!posts.length) return;

      var widgetsPromise = null;

      var loadTwitterWidgets = function () {
        if (window.twttr && window.twttr.widgets) {
          return Promise.resolve(window.twttr);
        }
        if (widgetsPromise) return widgetsPromise;

        widgetsPromise = new Promise(function (resolve, reject) {
          var script = document.createElement('script');
          script.async = true;
          script.src = 'https://platform.twitter.com/widgets.js';
          script.charset = 'utf-8';
          script.onload = function () {
            if (window.twttr && window.twttr.ready) {
              window.twttr.ready(function (twttr) {
                resolve(twttr);
              });
              return;
            }
            resolve(window.twttr);
          };
          script.onerror = reject;
          document.head.appendChild(script);
        });

        return widgetsPromise;
      };

      var hydratePost = function (post) {
        if (post.getAttribute('data-fanart-loaded') === 'true') return;
        post.setAttribute('data-fanart-loaded', 'true');

        var embed = post.querySelector('[data-fanart-embed]');
        var template = post.querySelector('[data-fanart-template]');
        if (!embed || !template) return;

        embed.innerHTML = template.innerHTML;
        loadTwitterWidgets().then(function (twttr) {
          if (twttr && twttr.widgets) {
            twttr.widgets.load(embed);
          }
        }).catch(function () {
          post.removeAttribute('data-fanart-loaded');
        });
      };

      if ('IntersectionObserver' in window) {
        var observer = new IntersectionObserver(function (entries, obs) {
          entries.forEach(function (entry) {
            if (!entry.isIntersecting) return;
            hydratePost(entry.target);
            obs.unobserve(entry.target);
          });
        }, { rootMargin: '600px 0px' });

        posts.forEach(function (post) {
          observer.observe(post);
        });
      } else {
        posts.forEach(hydratePost);
      }
    })();
  </script>
{% endif %}
