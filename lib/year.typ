#import "grids.typ": grids

#let yearPage(year) = {
  page()[
    #grids()
    #place(top + left, image("../svgs/year.svg", width: 100%, height: 100%))
    #place(top + center, dy: 30pt, text("YEAR " + str(year), font:  "Open Sans", weight: "semibold", stretch: 75%, size:  60pt))
  ]
}