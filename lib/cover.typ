#import "grids.typ"

#let coverPage(year) = {
  let gridCtx = grids.calcContext()

  page()[
    #grids.render(..gridCtx) 
    #place(
      top + left,
      dx: grids.xPos(gridCtx, 16),
      dy: grids.yPos(gridCtx, 36),
      box(
        width: grids.span(gridCtx, 16),
        fill: white,
        radius: 20pt,
        pad(
          grids.span(gridCtx, 2),
          align(left, 
            text(str(year) + "\n", size: 200pt)
            +
            text("DAILY JOURNAL\n", size: 100pt)
            +
            pad(
              right: grids.span(gridCtx, 1),
              align(right, text("Designed by Jaide", size: 30pt, stretch: 100%))
            )
          )
        )
      )
    )
  ]
}