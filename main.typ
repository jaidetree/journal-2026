#import "config.typ" as cfg
#import "lib/grids.typ"
#import "lib/cover.typ": coverPage
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
  coverPage(year)

  page()[
    #grids.grids()
  ]
  
  page( )[
    #grids.grids()
    #place(top + left, image("svgs/vision-board.svg", width: 100%, height: 100%))
  ]
  
  yearPage(year)
  
  projectsPage()
  
  for monthNum in range(1, 11) {
    let monthDate = datetime(year: year, month: monthNum, day: 1)
    let daysInMonth = calcDaysInMonth(monthDate)
    
    monthPage(monthDate, daysInMonth)

    // Account for Jan 1st not being on a Sunday
    if monthDate.weekday() != 7 {
      weekPage(calcWeekStart(monthDate, monthDate.day()))
    }

    for dayNum in range(1, daysInMonth + 1) {
      let dayDate = datetime(year: year, month: monthNum, day: dayNum)

      if dayDate.weekday() == 7 {
        let weekDate = calcWeekStart(monthDate, dayNum)
        weekPage(weekDate)
      }


      dayPage(dayDate)
    }
  }
}

#generate(year: 2026)