#' @title Exclusion
#'
#' @description Filters dataset by rows (normally: subjects, observations) and
#'   prints the numbers of excluded rows and remaining rows. Returns the
#'   filtered dataset and (optionally) also the excluded rows.
#' @param dat Data frame to be filtered.
#' @param filt An expression to use for filtering, by column values, the
#'   \code{dat} data frame. (Only the rows for which the filter expression is
#'   \code{TRUE} will be kept.)
#' @param excluded Logical; \code{FALSE} by default. If \code{TRUE}, the
#'   function returns not only the filtered data frame, but also a data frame
#'   containing the excluded rows. The returned object in this case will be a
#'   list with two elements: (1) the filtered data frame named \code{filtered},
#'   and (2) the data frame with excluded rows named \code{excluded} (see
#'   Examples).
#' @param group_by String, or vector of strings: the name(s) of the column(s) in
#'   the \code{dat} data frame, containing the vector(s) of factors by which the
#'   printed counts are grouped.
#' @param sort_by String; specifies whether the printed counts should be sorted
#'  by exclusion (default; \code{"exclusion"} or its short forms, e.g.
#'  \code{"excl"}), or by the factors given for \code{group_by} (for this, give
#'  any other string, e.g. \code{"conditions"}). If \code{NULL} (default).
#' @param hush Logical. If \code{TRUE}, prevents printing counts to console.
#' @return A data frame with the rows for which the \code{filt} expression is
#'   \code{TRUE}, or, optionally, a list with this data frame plus a data frame
#'   with the excluded rows. At the same time, prints, by default, the count of
#'   remaining and excluded rows.
#' @seealso \code{\link{aggr_neat}}
#' @examples
#'
#' data("mtcars") # load base R example dataset
#'
#' # filter mtcars for mpg > 20
#' excl_neat(mtcars, mpg > 20)
#'
#' # assign the same
#' mtcars_filtered = excl_neat(mtcars, mpg > 20)
#' # (mtcars_filtered now contains the filtered subset)
#'
#' # return and assign excluded rows too
#' mtcars_filtered_plus_excluded = excl_neat(mtcars, mpg > 20, excluded = TRUE)
#'
#' # print filtered data frame
#' print(mtcars_filtered_plus_excluded$filtered)
#'
#' # print data frame with excluded rows
#' print(mtcars_filtered_plus_excluded$excluded)
#'
#' # group printed count by cyl
#' excl_neat(mtcars, mpg > 20, group_by = 'cyl')
#'
#' # sort output by grouping
#' excl_neat(mtcars, mpg > 20, group_by = 'cyl', sort_by = 'group')
#'
#' # group by cyl amd carb
#' excl_neat(mtcars, mpg > 15, group_by = c('cyl', 'carb'))
#'
#' # longer filter expression
#' excl_neat(mtcars, mpg > 15 & gear == 4, group_by = 'cyl',)
#'
#' @export

excl_neat = function(dat,
                     filt,
                     excluded = FALSE,
                     group_by = NULL,
                     sort_by = 'exclusion',
                     hush = FALSE) {
    if (typeof(dat) == "character") {
        dat = eval(parse(text = dat))
    }
    validate_args(match.call(),
                  list(
                      val_arg(dat, c('df')),
                      val_arg(excluded, c('bool'), 1),
                      val_arg(group_by, c('null', 'char')),
                      val_arg(sort_by, c('char'), 1),
                      val_arg(hush, c('bool'), 1)
                  ))
    name_taken('..neat_ids', dat)
    dat$..neat_ids = paste0('id', seq.int(nrow(dat)))
    filt = paste(deparse(substitute(filt)), collapse = "")
    if (filt != "NULL") {
        if (startsWith(filt, "'") | startsWith(filt, '"')) {
            stop('The argument "filt" must be an expression (not string).')
        }
        filt_vec = eval(parse(text = paste0('with(data = dat, ',
                                            filt,
                                            ')')))
        na_sum = sum(is.na(filt_vec))
        if (na_sum > 0) {
            message(
                'Note: ',
                na_sum,
                ' NA values were replaced as FALSE for filtering.',
                ' You may want to double-check your filtering expression.'
            )
            filt_vec[is.na(filt_vec)] = FALSE
        }
        dat_filted = dat[filt_vec,]
    }
    dat$remaining = ifelse(dat$..neat_ids %in% dat_filted$..neat_ids,
                           'remained',
                           'excluded')
    if (hush == FALSE) {
        if (substr("exclusion", 1, nchar(sort_by)) == sort_by) {
            grouppin = c(group_by, 'remaining')
        } else {
            grouppin = c('remaining', group_by)
        }
        print(
            aggr_neat(
                dat = dat,
                values = '..neat_ids',
                group_by = grouppin,
                method = length,
                new_name = 'count'
            )
        )
    }
    if (excluded == TRUE) {
        dat_excl = dat[dat$remaining == 'excluded',]
        dat_excl$remaining = NULL
        dat_excl$..neat_ids = NULL
        dat_filted$..neat_ids = NULL
        invisible(list(filtered = dat_filted, excluded = dat_excl))
    } else {
        dat_filted$..neat_ids = NULL
        invisible(dat_filted)
    }
}
