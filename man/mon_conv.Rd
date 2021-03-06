% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mon_neat.R
\name{mon_conv}
\alias{mon_conv}
\title{Monitor Screen Unit Conversion}
\usage{
mon_conv(mon_obj, value, from, to)
}
\arguments{
\item{mon_obj}{Monitor object, as assigned with \code{\link{mon_neat}}.}

\item{value}{Number; value (magnitude) of the given unit to convert from.
(Can be vector as well.)}

\item{from}{String; unit ("cm", "pix", or "deg") to convert from.}

\item{to}{String; unit ("cm", "pix", or "deg") to convert to.}
}
\value{
Number (magnitude) in the given output (\code{to}) unit.
}
\description{
Given a specific monitor object, converts specified screen units to
  other specified units. The possible units to convert from and to: "cm"
  (centimeters), "pix" (pixels), or "deg" (degrees of visual angle).
}
\examples{
# assign monitor with 50 cm distance, screen width 52 cm and 1920 pixels
my_mon = mon_neat(distance = 50, mon_width_cm = 52, mon_width_pixel = 1920)

# convert 30.4 pixels to degrees of visual angle, for the specified monitor
mon_conv(my_mon, 30.4, 'pix', 'deg') # returns 0.9434492 (degrees)

# convert 0.94 degrees of visual angle to pixels
mon_conv(my_mon, 0.94, 'deg', 'pix') # returns 30.28885 (pixels)

# convert 10 degrees of visual angle to cm
mon_conv(my_mon, 10, from = 'deg', to = 'cm')

# convert 8.748866 cm to pixels
mon_conv(my_mon, 8.748866, from = 'cm', to = 'pix')
}
\seealso{
\code{\link{mon_neat}}
}
