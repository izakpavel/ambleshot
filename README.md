# AmbleShot
Sample app storing pictures every 100m while walking

![Example](https://github.com/izakpavel/ambleshot/blob/master/screenshot.jpg)

# Notes
* coded as an evaluation task
* written in SwiftUI & Combine, no 3rd party libs used
* timeline is persisted as JSON
* features shot timeline with image details, both with proper empty states
* light/dark mode supported

# Possible improvements

* proper networking - no subscription to changes of connection status. In current implementation, missing images are re-loaded when app enter foreground
* filtering out duplicate photos
* storing multiple AmbleShot timelines - now the timeline is reset with each start
