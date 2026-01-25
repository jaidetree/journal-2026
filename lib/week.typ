#import "grids.typ"

#let weekDayZero(weekDate) = {
  let dayOfWeek = weekDate.weekday()

  if dayOfWeek == 7 { 0 } else { dayOfWeek }
}

#let calcWeekStart(monthDate, weekOfDay) = {
  let weekDate = datetime(year: monthDate.year(), month: monthDate.month(), day: weekOfDay)
  let dayOfWeek = weekDayZero(weekDate)
  let weekStart = weekDate - duration(days: dayOfWeek)

  weekStart
}

#let weekPage(weekStartDate) = {
  let gridCtx = grids.calcContext()

  page()[
    #grids.render(..gridCtx) 
    
    #place(top + left, image("../svgs/week.svg", width: 100%, height: 100%))

    #for d in range(0, 7) {
      let weekDate = weekStartDate + duration(days: d)
      
      place(
        top + left, 
        dx: grids.xPos(gridCtx, d * 5),
        dy: grids.yPos(gridCtx, 1),
        box(
          width: grids.span(gridCtx, 5),
          height: grids.span(gridCtx, 1),
          align(center + horizon, text(size: 28pt, upper(weekDate.display("[month repr:long] [day], [year]"))))
        )
      )
    }
  ]
}
