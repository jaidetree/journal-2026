#import "../config.typ" as cfg

#let grids(width: cfg.pageWidth, height: cfg.pageHeight, margin: cfg.pageMargin, gridStrokeWidth: 1pt, subGridSize: 25pt, baseGridSize: 50pt, dotGridRadius: 4.5pt) = {
  let dotGridOffset = -1 * dotGridRadius
  
  // Setup page properties
  
  // set page(margin: margin, width: width, height: height, fill: white)
  
  // Grids
  
  // Define the subGrid pattern and color
  let subGridStroke = gridStrokeWidth + rgb("#bbbbbb")
  let subGridPattern = tiling(size: (subGridSize, subGridSize))[
    #place(line(start: (0%, 0%), end: (0%, 100%), stroke: subGridStroke))
    #place(line(start: (0%, 0%), end: (100%, 0%), stroke: subGridStroke))
  ]
  
  // Define the baseGrid pattern and color
  let baseGridStroke = gridStrokeWidth + rgb("#aaaaaa")
  let baseGridPattern = tiling(size: (baseGridSize, baseGridSize))[
    #place(line(start: (0%, 0%), end: (0%, 100%), stroke: baseGridStroke))
    #place(line(start: (0%, 0%), end: (100%, 0%), stroke: baseGridStroke))
  ]
  
  // Define the dotGrid pattern and color
  let dotGridColor = rgb("#999999")
  let dotGridPattern = tiling(size: (baseGridSize, baseGridSize))[
    #place(circle(radius: dotGridRadius, fill: dotGridColor))
  ]
  
  // Center the grids on the page
  let frameWidth = width - (2 * margin)
  let frameHeight = height - (2 * margin)
  let xOffset = ((frameWidth - (calc.floor(frameWidth / baseGridSize) * baseGridSize))) / 2
  let yOffset = ((frameHeight - (calc.floor(frameHeight / baseGridSize) * baseGridSize))) / 2
  
  // Fill the sub-grid and base-grids
  place(top + left, dx: xOffset, dy: yOffset, rect(fill: subGridPattern, width: 100% - xOffset, height: 100% - yOffset))
  place(top + left, dx: xOffset, dy: yOffset, rect(fill: baseGridPattern, width: 100% - xOffset, height: 100% - yOffset))
  
  // Draw a rectangle around the grid elements at the margin
  place(top + left, rect(stroke: 2pt + rgb("#000000"), width: 100%, height: 100%))
  
  place(top + left, dx: dotGridOffset + xOffset, dy: dotGridOffset + yOffset, rect(fill: dotGridPattern, width: 100%, height: 2560pt - baseGridSize))
  
  // Draw a line marking the always visible space on the right when the toolbar is open
  place(top + left, line(start: (xOffset + (2 * baseGridSize), 0pt), end: (xOffset + (2 * baseGridSize), frameHeight), stroke: 2pt + rgb("#999")))
}
