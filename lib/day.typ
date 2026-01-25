#import "../config.typ" as cfg
#import "grids.typ"

#let dayPage(dayDate) = {
  let gridCtx = grids.calcContext()
  
  page()[
    #grids.render(..gridCtx)
    #place(top + left, image("../svgs/day.svg", width: 100%, height: 100%))

    // Place date info
    #place(
      top + left, 
      dx: grids.xPos(gridCtx, 0),
      dy: grids.yPos(gridCtx, 0.55),
      box(
        width: grids.span(gridCtx, 35),
        height: grids.span(gridCtx, 2),
        upper(dayDate.display("[weekday]")) + h(1fr) + upper(dayDate.display("[month repr:long] [day], [year]"))
      )
    )

    #for h in range(0, cfg.habits.len()) {
      let habit = cfg.habits.at(h)

      place(
        top + left, 
        dx: grids.xPos(gridCtx, 25.4) + grids.span(gridCtx, h * 1.5),
        dy: grids.yPos(gridCtx, 13.5),
        rotate(
          origin: bottom + left, 
          -75deg,
          text(size: 33pt, upper(habit))
        ),
      )
    }
  ]
}