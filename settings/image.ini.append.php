<?php /* #?ini charset="utf-8"?

[ImageMagick]

# strip exif info etc.
Filters[]=strip=-strip
# resize up+down to fill %1x%2, overflowing if necessary
Filters[]=geometry/resizetofillarea=-resize %1x%2^
# crop to size %2x%3 staring at point %4,%5 relative to gravity %1 (NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast)
Filters[]=geometry/cropwithgravity=-gravity %1 -crop %2x%3+%4+%5 +repage
# None Line Plane Partition
Filters[]=interlace=-interlace %1

*/ ?>