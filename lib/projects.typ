#import "grids.typ": grids

#let projectsPage() = {
  page()[
    #grids()
    #place(top + left, image("../svgs/projects.svg", width: 100%, height: 100%))
    #place(top + center, dy: 20pt, text("PROJECTS", font:  "Open Sans", weight: "semibold", stretch: 75%, size:  60pt))
  ]
}