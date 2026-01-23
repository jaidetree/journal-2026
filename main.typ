#import "config.typ" as cfg
#import "lib/grids.typ": grids
#import "lib/year.typ": yearPage
#import "lib/projects.typ": projectsPage
#import "lib/month.typ": monthPage

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
  page( )[
    #grids()
    #place(top + left, image("svgs/vision-board.svg", width: 100%, height: 100%))
  ]
  
  yearPage(year)
  
  projectsPage()
  
  // Generate an array of data
  
  for monthNum in range(1, 11) {
    let monthDate = datetime(year: year, month: monthNum, day: 1)
    monthPage(monthDate)
  }
  
  page()[
    #grids()
    #place(top + left, image("svgs/week.svg", width: 100%, height: 100%))
  ]
  
  page()[
    #grids()
    #place(top + left, image("svgs/day.svg", width: 100%, height: 100%))
  ]
}

#generate(year: 2026)