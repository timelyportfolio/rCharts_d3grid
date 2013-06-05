---
title: rCharts with d3-grid
subtitle: Some Early Experiments
author: Timely Portfolio
github: {user: timelyportfolio, repo: rCharts_d3grid, branch: "gh-pages"}
framework: bootstrap
mode: selfcontained
widgets: [d3-grid]
highlighter: prettify
hitheme: twitter-bootstrap
---

<style>
body {
  font-family: Helvetica, sans-serif;
}
svg {
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
}
.filter-btn.active {
  font-weight: bold;
}
</style>
<body>
Color
<a href="#" class="filter-btn" data-filter="color" data-value="all">all</a> /
<a href="#" class="filter-btn" data-filter="color" data-value="pink">pink</a> /
<a href="#" class="filter-btn" data-filter="color" data-value="blue">blue</a>
<br>
Shape
<a href="#" class="filter-btn" data-filter="shape" data-value="all">all</a> /
<a href="#" class="filter-btn" data-filter="shape" data-value="square">square</a> /
<a href="#" class="filter-btn" data-filter="shape" data-value="circle">circle</a>
