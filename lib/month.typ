#import "../config.typ" as cfg
#import "grids.typ": grids

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

  page()[
    #grids()
    #place(top + left, image("../svgs/month.svg", width: 100%, height: 100%))
    
    #for d in range(1, daysInMonth + 1) {
      let dayDate = datetime(year: year, month: monthNum, day: d)
      let dayDateStr = dayDate.display("[weekday repr:short]").slice(0, 1)
      place(top + left, dx: 35pt + 50pt * 2, dy: 180pt + 50pt * d, text(str(d), size: 24pt,  fill: luma(40%))) 
      place(top + left, dx: 85pt + 50pt * 2, dy: 180pt + 50pt * d, align(center, text(dayDateStr, size: 24pt,  fill: luma(40%))))
    }

    #for d in range(firstDay + weekdayOffset, daysInMonth + 1, step: 7) {
      place(top + left, dx: 50pt * 2, dy: 10pt, line(start: (12.5pt, d * 50pt), end: (100%, d * 50pt), stroke: 4pt + black)) 
    }

    #place(top + left, dx: 50pt * 2, dy: 210pt, line(
      start: (12.5pt, daysInMonth * 50pt), 
      end: (100% - 112.5pt, daysInMonth * 50pt), 
      stroke: 4pt + black
    ))

    #for h in range(0, cfg.habits.len()) {
      let habit = cfg.habits.at(h)
      place(top + left, dx: 1450pt + h * 50pt, dy: 180pt, rotate(-75deg, text(upper(habit), size: 30pt), origin: bottom + left))
    }
    
    #place(top + left, dx: 625pt, dy: 66pt, text(upper(monthName) + " " + str(year)))
  ]
}