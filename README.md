# ambleshot
Sample app storing pictures every 100m while walking

# Notes
* coded as an evaluation task
* written in SwiftUI & Combine, no 3rd party libs used

# Possible improvements

* proper networking - no subscription to changes of connection status. In current implementation, missing images are re-loaded when app enter foreground
* filtering out duplicate photos
* storing multiple AmbleShot timelines - now the timeline is reset with each start
