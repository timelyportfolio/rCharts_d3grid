---
title: rCharts with d3-grid
subtitle: Some Early Experiments
author: Timely Portfolio
github: {user: timelyportfolio, repo: rCharts_d3grid, branch: "gh-pages"}
framework: bootstrap
mode: selfcontained
widgets: [d3grid]
highlighter: prettify
hitheme: twitter-bootstrap
---

  <div class = "span2 sidebar">
  <h3>rCharts and d3-grid</h3>
  An early experiment with [d3-grid](https://github.com/interactivethings/d3-grid) motivated by [Herr Stucki](http://bl.ocks.org/herrstucki).  I would like to make some of the d3-grid capabilities available through rCharts primarily for use in small multiples or lattice-like strips.  Since I am having trouble deciding what to provide with an rCharts implementation, I wanted to replicate each of Stucki's three examples.  But before that, I wanted to just draw a table like layout with each of the cells colored based on their location.<br/><br/>
  </div>
  <div class = "span5 main">

```r
require(rCharts)

grid1 <- rCharts$new()
grid1$field("lib", "libraries/widgets/d3grid")

grid1$set(height = 500, width = 960, container = ".rChart", size = 400, nrow = 8, 
    ncol = 8, bands = TRUE, data = 1:64)
grid1$print()
```


<div id='chart320c68e354c3' class='rChart d3grid'></div>
<script>
//get parameters from rCharts
var params = {
 "dom": "chart320c68e354c3",
"width":    960,
"height":    500,
"container": ".rChart",
"size":    400,
"nrow":      8,
"ncol":      8,
"bands": true,
"data": [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64 ],
"id": "chart320c68e354c3" 
}

var width = params.width,
    height = params.height;

var grid = d3.layout.grid()
  .rows( params.nrow )
  .cols( params.ncol )
  .size([ params.size, params.size]);

if (params.bands == true) {
    grid.bands();
} else {
    grid.points();
}
    
var svg = d3.select(params.container).append("svg")
  .attr({
    width: width,
    height: height
  });

var svgGrid = svg.append("g")
  .attr("transform", "translate(100,50)");

var cells = svgGrid.selectAll("g")
  .data(grid(d3.entries(params.data.map(function(d,i) { return [d]; }))))  //thanks http://stackoverflow.com/questions/3751520/how-to-generate-sequence-of-numbers-chars-in-javascript
    .enter()
      .append("g")
        .attr("class", "cell")
        .attr("id", function(d) { return +d.key;})
        .attr("transform", function(d, i) {
           return "translate(" + d.x + "," + d.y + ")"
         });

</script>

<script>
  var color = d3.scale.linear()
    .domain([0, 32, 63])
    .range(["red", "lightgray", "green"]);
  //thanks again http://stackoverflow.com/questions/3751520/how-to-generate-sequence-of-numbers-chars-in-javascript
  cells.selectAll("rect")
    .data(function(d) {return d.value})
      .enter().append("rect")
        .attr("width", grid.nodeSize()[0])
        .attr("height", grid.nodeSize()[1])
        .style("fill", function(d) {return color(d)});
</script>
  </div>
</div>
