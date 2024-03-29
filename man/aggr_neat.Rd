% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggr_neat.R
\name{aggr_neat}
\alias{aggr_neat}
\title{Aggregation, descriptives}
\usage{
aggr_neat(
  dat,
  values,
  method = mean,
  group_by = NULL,
  filt = NULL,
  sep = "_",
  prefix = NULL,
  new_name = NULL,
  round_to = 2
)
}
\arguments{
\item{dat}{A data frame (or a \code{\link{data.table}}, or the name of either
as string).}

\item{values}{The vector of numbers from which the statistics are to be
calculated, or the name of the column in the \code{dat} data frame, that
contains the vector.}

\item{method}{Function of string. If function, uses the \code{values} to
calculate the returned value for the given function (e.g. means, as per
default, using the \code{mean} function). Such a function may return a
vector of results as well; see Examples. If string, one of two internal
functions will be used. If the string end with \code{"+sd"}, e.g.,
\code{"mean+sd"}, the function preceding the \code{"+"} sign will be
calculated along with the standard deviation, displayed in a single column,
rounded as set in the \code{round_to} argument. (This is primarily for use
in the \code{\link{table_neat}} function for summary tables.) If the string
does not end with \code{"+sd"}, a ratio for the occurrences of given
elements will be calculated. Multiple elements can by given as a vector of
strings. The number of occurrences of these elements will be the numerator
(dividend), while the entire column length (i.e., number of all elements)
will be the denominator (divisor). For example, if a column contains
elements \code{"correct"}, \code{"incorrect"}, \code{"tooslow"}, the ratio
of \code{"correct"} to all other elements (i.e., including elements
\code{"correct"}, \code{"incorrect"}, and \code{"tooslow"}) can be written
simply as \code{method = "correct"}. The complementary ratio, of
\code{"incorrect"} and \code{"tooslow"}, can be written as \code{method =
"incorrect, tooslow"}. (Hint: filter to get ratios of subgroups, e.g. to
include only \code{"correct"} and \code{"incorrect"} elements, and
calculate their ratio; see below.)}

\item{group_by}{String, or vector of strings: the name(s) of the column(s) in
the \code{dat} data frame, containing the vector(s) of factors by which the
statistics are grouped.}

\item{filt}{An expression to filter, by column values, the entire \code{dat}
data frame before performing the aggregation. The expression should use
column names alone; see Examples.}

\item{sep}{String (underscore \code{"_"} by default) for separating group
names (and prefix, if given).}

\item{prefix}{\code{NULL} (default) or string. String specifies a prefix for
each group type under the \code{group} column.}

\item{new_name}{\code{NULL} (default) or string. String specifies new name
for the variable to be used as column title. If \code{NULL}, the name will
be \code{"aggr_value"} (or, if used with \code{\link{table_neat}}, the
input variable name is used).}

\item{round_to}{Number of digits after the decimal point to round to, when
using \code{"+sd"} in \code{method}.}
}
\value{
A \code{\link{data.table}} with the statistics per group, with a
  single column (\code{"aggr_group"}) indicating the grouping.
}
\description{
Returns aggregated values per group for given variable. Serves
  as argument in the \code{\link{table_neat}} function.
}
\examples{
data("mtcars") # load base R example dataset

# overall means and SDs for wt (Weight)
aggr_neat(mtcars, wt)

# rename column
aggr_neat(mtcars, wt, new_name = 'weight')

# grouped by cyl (Number of cylinders)
aggr_neat(mtcars, wt, group_by = 'cyl')

# grouped by cyl and gear
aggr_neat(mtcars, wt, group_by = c('cyl', 'gear'))

# prefix for group names
aggr_neat(mtcars, wt, group_by = 'cyl', prefix = 'cyl')

# filter to only have cyl larger than  4
aggr_neat(mtcars, wt, group_by = 'cyl', filt = cyl > 4)

# filter to only have hp (Gross horsepower) smaller than  200
aggr_neat(mtcars, wt, group_by = 'cyl', filt = hp < 200)

# combine two filters above, and add prefix
aggr_neat(
    mtcars,
    wt,
    group_by = 'cyl',
    filt = (hp < 200 & cyl > 4),
    prefix = 'filtered'
)

# add SD (and round output numbers to 2)
aggr_neat(mtcars,
          wt,
          group_by = 'cyl',
          method = 'mean+sd',
          round_to = 2)

# now medians instead of means
aggr_neat(mtcars, wt, group_by = 'cyl', method = median)

# with SD
aggr_neat(mtcars,
          wt,
          group_by = 'cyl',
          method = 'median+sd',
          round_to = 1)

# overall ratio of gear 4 (Number of gears)
aggr_neat(mtcars, gear, method = '4')

# overall ratio of gear 4 and 5
aggr_neat(mtcars, gear, method = '4, 5')

# same ratio calculated per each cyl
aggr_neat(mtcars, gear, group_by = 'cyl', method = '4, 5')

# per each cyl and per vs (engine type)
aggr_neat(mtcars,
          gear,
          group_by = c('cyl', 'vs'),
          method = '4, 5')

# ratio of gear 3 per gear 3 and 5
aggr_neat(
    mtcars,
    gear,
    group_by = 'cyl',
    method = '3',
    filt = gear \%in\% c(3, 5)
)

}
\seealso{
\code{\link{table_neat}} to create full tables using multiple
  variables
}
