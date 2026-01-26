# Journal Templates for 2026

A collection of custom journal templates for 2026 aimed for e-ink tablets such as the Supernote. 

## Usage

Use the Typst link below to see the live preview of the journal template. From there you can export a PDF or make a copy of the project and customize it to your needs. 

https://typst.app/project/r2RVSmkb6ROSQ4HQR1xhe4

## Features

- Cover page
- Blank grid template
- 5 columns x 6 row bingo grid
- Year page
- Projects or Goals Kanban page
- Month overview page
- Week overview page
- Day page

## Technology

The templates created with [Typst](https://typst.app), a document typesetting language with drawing features and a well optimized PDF export.

The designs for each feature are created as an SVG as I wanted to be able to design layouts visually instead of progmatically. 

In the future I may find or create a tool to convert the SVGs to raw Typst so it can be fully customized within typst or as SVGs.

## Customization

### How do I change the year?

Update the main.typ file and look for the following at the bottom of the file:

```typst
#generate(year: 2026)
```

Replace `2026` with the target year and the rest of the pages will be regenerated based on the target year.

### How do I customize the grid or page dimensions?

The easiest way to change the grid or page dimensions is to modify the config.typ file. However, you may need to modify the template SVGs to fit the updated dimensions.

### How do I customize the text on a page?

All the page types are defined in the `lib` directory, text should be able to be changed freely without any structural changes.

### How do I customize the design of a page?

Currently, all the templates are SVGs that can be edited in any graphics program such as Inkscape, Affinity, or Adobe Illustrator. It is recommended to use any available grid settings to match the baseGridSize in the config.typ file to provide the best designing experience. Each SVG should match the dimensions of the page minus the margin and spacing to center the grids. 

```
width = 1920pt
margin = 20pt // Defined in config.typ
xOffset = 15pt // Spacing to center the grids in the document

svg-width = width - (2 * margin) - (2 * xOffset)
```

## Contributing

Contributions are welcome but it would be preferred if a issue in the github repo is created first as I may not approve every change or additional module. 

If you would prefer to create a Typst package, I would be happy to start linking them on the readme for users to add to their journals.

