#import "../config.typ" as cfg
#import "grids.typ"

#let weekdays = ("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")

#let normalizeWeekday(weekday) = {
  if weekday == 7 { 0 } else { weekday }
}

#let calendarPage(monthDate, daysInMonth) = {
  let gridCtx = grids.calcContext()
  let firstDayOffset = normalizeWeekday(monthDate.weekday())

  let totalDays = daysInMonth + firstDayOffset
  let rows = calc.ceil(totalDays / 7)
  let width = 35
  let height = 32

  let cellHeight = 5

  page()[
    #grids.render(..gridCtx)
    #place(
      top + left,
      dx: grids.xPos(gridCtx, 0),
      dy: grids.yPos(gridCtx, 2),
      rect(
        width: grids.span(gridCtx, 35),
        height: grids.span(gridCtx, 2),
        radius: (top: 20pt, bottom: 0pt),
        fill: luma(80%),
        stroke: 3pt + black,
        align(
          center + horizon,
          upper(text(monthDate.display("[month repr:long] [year]")))
        )
      )
    )
    
    #place(
      top + left,
      dx: grids.xPos(gridCtx, 0),
      dy: grids.yPos(gridCtx, 4),
      box(
        width: grids.span(gridCtx, width),
        height: grids.span(gridCtx, height),
        radius: 20pt,
        grid(
          columns: range(0, 7).map(_ => grids.span(gridCtx, width / 7)),
          rows: (grids.span(gridCtx, 2), ) + range(0, rows).map(_ => grids.span(gridCtx, cellHeight)),
          inset: 20pt,
          gutter: 0pt,
          stroke: 3pt + black,
          align: top + right,
          
          ..range(0, 7).map(d => grid.cell(
            fill: luma(90%),
            align: center + horizon,
            upper(text(size: 35pt, fill: luma(40%), weekdays.at(d)))
          )),
          
          ..range(0, firstDayOffset).map(d => {
            grid.cell(
              text(
                size: 30pt,
                fill: luma(60%),
                str((monthDate - duration(days: firstDayOffset - d)).day())
              )
            )
          }),
          
          ..range(1, daysInMonth + 1).map(d => grid.cell(
            text(
              size: 30pt,
              str(d)
            ) 
          ))
        )
      )
    )
  ]
}