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
/* copy and paste from original example */
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


/* my own for this project */
.container {
  width: 800px;
}
</style>

<div id = "content" class="row-fluid">
  <div class = "span3 sidebar">
    Color
    <a href="#" class="filter-btn" data-filter="color" data-value="all">all</a> /
    <a href="#" class="filter-btn" data-filter="color" data-value="pink">pink</a> /
    <a href="#" class="filter-btn" data-filter="color" data-value="blue">blue</a>
    <br>
    Shape
    <a href="#" class="filter-btn" data-filter="shape" data-value="all">all</a> /
    <a href="#" class="filter-btn" data-filter="shape" data-value="square">square</a> /
    <a href="#" class="filter-btn" data-filter="shape" data-value="circle">circle</a>
  </div>
  <div class = "span9 main">
    <svg></svg>
  </div>
</div>
<script>
var width = 960,
    height = 500;

var filters = {
  color: "all",
  shape: "all"
}

var grid = d3.layout.grid()
  .rows(8)
  .cols(8)
  .size([400, 400]);

var color = d3.scale.ordinal()
  .domain(["pink", "blue"])
  .range(["#F66A96", "#3E6E9C"]);

var size = d3.scale.linear()
  .domain([0, 9])
  .range([0, 2000]);

var symbol = d3.svg.symbol();

var sortBySize = d3.comparator()
  .order(d3.descending, function(d) { return d.size; });

var data = d3.range(64).map(function(d) { 
  return {
    id: d,
    size: 1 + Math.floor(Math.random() * 9),
    color: Math.random() > 0.5 ? "pink" : "blue",
    shape: Math.random() > 0.5 ? "square" : "circle"
  }; 
});

var svg = d3.selectAll("svg")
  .attr({
    width: width,
    height: height
  })
.append("g")
  .attr("transform", "translate(280,50)");

var filterButtons = d3.selectAll(".filter-btn")
  .on("click", function(d) {
    d3.event.preventDefault();
    filters[this.dataset.filter] = this.dataset.value;
    update();
  });

update();

function update() {
  var node = svg.selectAll(".node")
    .data(grid(data.filter(applyFilters).sort(sortBySize)), function(d) { return d.id; });
  node.enter().append("path")
    .attr("class", "node")
    .attr("d", function(d) { return symbol.type(d.shape).size(1e-9)(); })
    .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
    .style("fill", function(d) { return color(d.color); });
  node.transition().duration(1000).delay(function(d, i) { return i * 20; })
    .attr("d", function(d) { return symbol.type(d.shape).size(size(d.size))(); })
    .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  node.exit().transition()
    .attr("d", function(d) { return symbol.type(d.shape).size(1e-9)(); })
    .remove();

  filterButtons
    .classed("active", function(d) { return this.dataset.value === filters[this.dataset.filter]; });
}

function applyFilters(d) {
  for (var f in filters) {
    if (filters[f] === "all") continue;
    if (filters[f] !== d[f]) return false;
  }
  return true;
}

</script>

