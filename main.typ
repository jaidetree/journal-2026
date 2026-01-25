#import "config.typ" as cfg
#import "lib/grids.typ": grids, span, xPos, yPos
#import "lib/year.typ": yearPage
#import "lib/projects.typ": projectsPage
#import "lib/month.typ": monthPage, calcDaysInMonth
#import "lib/week.typ": weekPage, calcWeekStart
#import "lib/day.typ": dayPage

#set page(
  width: cfg.pageWidth,
  height: cfg.pageHeight,
  margin: cfg.pageMargin,
  fill: white
)

#set text(
  font: "Open Sans",
  weight: "semibold", 
  stretch: 75%, 
  size:  60pt
)

#let generate(year: 2026) = {
  page()[
    #grids()   
    #place(
      right + bottom,
      dy: -360pt,
      dx: -240pt,
      box(
        fill: white,
        stroke: 80pt + white, 
        align(left, 
          text("2026\n", size: 200pt)
          +
          text("DAILY JOURNAL\n", size: 100pt)
          +
          align(right,
          text("Designed by Jaide", size: 30pt, stretch: 100%))
        )
      )
    )
  ]
  
  page( )[
    #grids()
    #place(top + left, image("svgs/vision-board.svg", width: 100%, height: 100%))
  ]
  
  yearPage(year)
  
  projectsPage()
  
  // Generate an array of data
  
  for monthNum in range(1, 11) {
    let monthDate = datetime(year: year, month: monthNum, day: 1)
    let daysInMonth = calcDaysInMonth(monthDate)
    
    monthPage(monthDate, daysInMonth)

    for weekDayNum in range(1, daysInMonth) {
      let weekDate = calcWeekStart(monthDate, weekDayNum)

      if weekDate.weekday() == 7 {
        weekPage(weekDate)
      }

      for dayNum in range(0, 7) {
        let dayDate = weekDate + duration(days: dayNum)

        dayPage(dayDate)
      }
    }
  }
  
  page()[
    #grids()
    #place(top + left, image("svgs/day.svg", width: 100%, height: 100%))
  ]
}

#generate(year: 2026)