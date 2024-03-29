% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/norm_tests.R
\name{norm_tests}
\alias{norm_tests}
\title{Normality Tests and Plots}
\usage{
norm_tests(
  var1,
  var2 = NULL,
  pair = FALSE,
  norm_tests = "all",
  alpha = 0.05,
  plots = FALSE,
  aspect_ratio = 1,
  hush = FALSE
)
}
\arguments{
\item{var1}{Numeric vector; numbers of any given variable.}

\item{var2}{Optional numeric vector (or \code{NULL}); numbers of a second
variable.}

\item{pair}{Logical; only matters if \code{var2} is not null. In that case, if
\code{TRUE} each normality test is performed for the difference values
between the two variables in case of paired samples, or, if \code{FALSE},
separately for each of the two variables for unpaired samples.}

\item{norm_tests}{Normality tests. Any or all of the following character input
is accepted (as a single string or a character vector; case-insensitive):
\code{"W"} (Shapiro-Wilk), \code{"K2"} (D'Agostino), \code{"A2"}
(Anderson-Darling), \code{"JB"} (Jarque-Bera); see Notes. The option
\code{"all"} (default value) selects all four previous tests at the same
time.}

\item{alpha}{Numeric (\code{.05} by default), alpha level: if any p value if
below this alpha level, the function returns \code{TRUE}, otherwise
\code{FALSE}.}

\item{plots}{Logical: if \code{TRUE} adds histogram, density, and Q-Q plots.
(Note: in case of paired samples, Q-Q plots are plotted on a separate
figure. In RStudio, press on "Previous plot" under "Plots" to see these Q-Q
plots.)}

\item{aspect_ratio}{Aspect ratio of the plots: \code{1} (\code{1}/\code{1}) by
default. (Set to \code{NULL} for dynamic aspect ratio.)}

\item{hush}{Logical. If \code{TRUE}, prevents printing any details to console.}
}
\value{
Prints normality tests, and displays plots if so specified. Returns
 \code{TRUE} if any of the specified tests has p value below the specified
 \code{alpha}, otherwise returns \code{FALSE}.
}
\description{
Performs normality tests and creates related plots (histogram,
 density, Q-Q). This is primarily a subfunction of \code{\link{t_neat}} and
 \code{\link{anova_neat}}, but here it is available separately for other
 potential purposes.
}
\note{
Normality tests are all calculated via
\code{\link[fBasics:NormalityTests]{fBasics::NormalityTests}}, selected based
on the recommendation of Lakens (2015), quoting Yap and Sim (2011, p. 2153):
"If the distribution is symmetric with low kurtosis values (i.e. symmetric
short-tailed distribution), then the D'Agostino and Shapiro-Wilkes tests have
good power. For symmetric distribution with high sample kurtosis (symmetric
long-tailed), the researcher can use the JB, Shapiro-Wilkes, or
Anderson-Darling test." See url{https://github.com/Lakens/perfect-t-test} for
more details.
}
\examples{

norm_tests(stats::rnorm(100))
# should be normal...

}
\references{
Lakens, D. (2015). The perfect t-test (version 1.0.0). Retrieved from
https://github.com/Lakens/perfect-t-test.
\doi{https://doi.org/10.5281/zenodo.17603}

Yap, B. W., & Sim, C. H. (2011). Comparisons of various types of normality
tests. Journal of Statistical Computation and Simulation, 81(12), 2141–2155.
\doi{https://doi.org/10.1080/00949655.2010.520163}
}
\seealso{
\code{\link{t_neat}}
}
