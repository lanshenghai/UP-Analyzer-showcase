/* 站点导航与 Markdown 页面加载 */
(function () {
  const NAV_ITEMS = [
    { href: 'index.html', label: '首页' },
    { href: 'demo.html', label: '在线演示' },
    { href: 'about.html', label: '项目介绍' },
    { href: 'architecture.html', label: '架构设计' },
    { href: 'up-analyzer-extra.html', label: '插件生态' },
    { href: 'ai-investigation.html', label: 'AI 调查' },
    { href: 'sample-report.html', label: '报告样例' },
    { href: 'demo-video-script.html', label: '视频分镜' },
    { href: 'recording-guide.html', label: '录制指南' },
    { href: 'desensitization-checklist.html', label: '脱敏清单' },
  ];

  window.injectSiteNav = function (activeHref) {
    const el = document.getElementById('site-nav');
    if (!el) return;
    const current = activeHref || location.pathname.split('/').pop() || 'index.html';
    el.className = 'site-nav';
    el.innerHTML = '<a class="brand" href="index.html">UP-Analyzer</a>' +
      NAV_ITEMS.map(function (item) {
        const cls = item.href === current ? ' class="active"' : '';
        return '<a href="' + item.href + '"' + cls + '>' + item.label + '</a>';
      }).join('');
  };

  window.loadMdPage = function (mdPath, activeHref) {
    injectSiteNav(activeHref);
    const target = document.getElementById('content');
    if (!target) return;

    fetch(mdPath)
      .then(function (r) {
        if (!r.ok) throw new Error('无法加载 ' + mdPath);
        return r.text();
      })
      .then(function (text) {
        if (typeof marked !== 'undefined') {
          marked.setOptions({ gfm: true, breaks: false });
          target.innerHTML = marked.parse(text);
        } else {
          target.innerHTML = '<pre>' + text.replace(/</g, '&lt;') + '</pre>';
        }
        // 站内 .md 链接 → .html
        target.querySelectorAll('a[href$=".md"]').forEach(function (a) {
          var href = a.getAttribute('href');
          var name = href.split('/').pop().replace('.md', '.html');
          if (href.indexOf('sample-investigation') >= 0 || href.indexOf('sample-report') >= 0) {
            name = 'sample-report.html';
          } else if (href.indexOf('ai-investigation') >= 0) {
            name = 'ai-investigation.html';
          } else if (href.indexOf('desensitization') >= 0) {
            name = 'desensitization-checklist.html';
          } else if (href.indexOf('demo-video') >= 0) {
            name = 'demo-video-script.html';
          } else if (href.indexOf('recording') >= 0) {
            name = 'recording-guide.html';
          } else if (href.indexOf('architecture') >= 0) {
            name = 'architecture.html';
          } else if (href.indexOf('up-analyzer-extra') >= 0) {
            name = 'up-analyzer-extra.html';
          }
          a.setAttribute('href', name);
        });
      })
      .catch(function (err) {
        target.innerHTML = '<p style="color:#cf222e">加载失败：' + err.message + '</p>';
      });
  };
})();
