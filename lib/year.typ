#import "grids.typ"

#let yearPage(year) = {
  let gridCtx = grids.calcContext()
  
  page()[
    #grids.render(..gridCtx)
    #place(top + left, image("../svgs/year.svg", width: 100%, height: 100%))
    #place(top + center, dy: grids.yPos(gridCtx, 0.1), text("YEAR " + str(year), font:  "Open Sans", weight: "semibold", stretch: 75%, size:  60pt))
  ]
}