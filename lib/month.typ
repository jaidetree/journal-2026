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

  text(str(firstDay))

  page()[
    #grids()
    #place(top + left, image("../svgs/month.svg", width: 100%, height: 100%))
    
    #for d in range(firstDay + weekdayOffset, daysInMonth + 1, step: 7) {
      let dayDate = datetime(year: year, month: monthNum, day: d)
      let dayDateStr = dayDate.display("[weekday repr:short]")
      place(top + left, dx: 50pt * 2, dy: 10pt, text(dayDateStr)) 
    }

    #for d in range(firstDay + weekdayOffset, daysInMonth + 1, step: 7) {
      place(top + left, dx: 50pt * 2, dy: 10pt, line(start: (12.5pt, d * 50pt), end: (100%, d * 50pt), stroke: 4pt + black)) 
    }

    #for d in range(0, daysToHide) {
      place(top + left, dx: 167pt, dy: (daysInMonth - d) * 50pt + 311pt, rect(width: 46pt, height: 47pt, fill: luma(90%)))
    }
    
    #place(top + left, dx: 625pt, dy: 55pt, text(upper(monthName) + " " + str(year)))
  ]
}