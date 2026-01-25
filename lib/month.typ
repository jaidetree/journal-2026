#import "../config.typ" as cfg
#import "grids.typ"

#let calcDaysInMonth(monthDate) = {
  let monthNum = monthDate.month()
  let yearNum = monthDate.year()
  let nextMonthDate = if monthNum == 12 { 
    datetime(year: yearNum + 1, month: 1, day: 1) 
  } else {
    datetime(year: yearNum, month: monthNum + 1, day: 1) 
  }
  let lastDayDate = nextMonthDate - duration(days: 1)

  lastDayDate.day()
}

#let monthPage(monthDate) = {
  let monthName = monthDate.display("[month repr:long]")
  let year = monthDate.year()
  let monthNum = monthDate.month()
  let daysInMonth = calcDaysInMonth(monthDate)
  let daysToHide = 31 - daysInMonth
  let firstDay = monthDate.weekday()
  let weekdayOffset = 7 - firstDay

  let gridCtx = grids.calcContext()

  page()[
    #grids.render(..gridCtx)
    #place(top + left, image("../svgs/month.svg", width: 100%, height: 100%))
    
    #for d in range(1, daysInMonth + 1) {
      let dayDate = datetime(year: year, month: monthNum, day: d)
      let weekdayStr = dayDate.display("[weekday repr:short]").slice(0, 1)

      // Place the date number in the left-most column
      place(
        top + left, 
        dx: grids.xPos(gridCtx, 0), 
        dy: grids.yPos(gridCtx, 3 + d), 
        box(
          align(center + horizon, text(str(d), 
            size: 24pt,  
            fill: luma(40%)
          )), 
          width: 50pt, 
          height: 50pt
        )
      )
      
      // Place the weekday label in a column to the right of the date column
      place(
        top + left, 
        dx: grids.xPos(gridCtx, 1),
        dy: grids.yPos(gridCtx, 3 + d), 
        box(
          align(center + horizon,  text(weekdayStr, size: 24pt,  fill: luma(40%))),
          width: gridCtx.baseGridSize,
          height: gridCtx.baseGridSize,
        )
      )
    }

    // Place thicker lines to separate weeks
    #for d in range(firstDay + weekdayOffset, daysInMonth + 1, step: 7) {
      place(
        top + left, 
        dx: grids.xPos(gridCtx, 0), 
        dy: grids.yPos(gridCtx, 0), 
        line(
          start: (0pt, grids.span(gridCtx, d)), 
          end: (grids.span(gridCtx, 35), grids.span(gridCtx, d)), 
          stroke: 4pt + black
        )
      ) 
    }

    // Place thick line after last day in month
    #{
      let y = grids.span(gridCtx, daysInMonth)
      
      place(
        top + left, 
        dx: grids.xPos(gridCtx, 0), 
        dy: 210pt, 
        line(
          start: (0pt, y), 
          end: (grids.span(gridCtx, 35), y), 
          stroke: 4pt + black
        )
      )
    }

    // Place habit labels
    #for h in range(0, cfg.habits.len()) {
      let habit = cfg.habits.at(h)
      
      place(
        top + left, 
        dx: grids.xPos(gridCtx, 26.75) + grids.span(gridCtx, h), 
        dy: grids.yPos(gridCtx, 3.25), 
        rotate(-75deg, text(upper(habit), size: 30pt), origin: bottom + left)
      )
    }

    // Place title including month
    #place(
      top + left, 
      dx: grids.xPos(gridCtx, 3), 
      dy: grids.yPos(gridCtx, 1), 
      box(
        width: grids.span(gridCtx, 22), 
        height: grids.span(gridCtx, 2),
        align(center + horizon, text(upper(monthName) + " " + str(year)))
      )
    )
  ]
}