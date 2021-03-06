% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.utilities.R
\name{persistEval}
\alias{persistEval}
\alias{persistEvalQ}
\title{Evaluate an expression, restarting on error}
\usage{
persistEval(
  expr,
  retries = NVL(getOption("eval.retries"), 5),
  beforeRetry,
  envir = parent.frame(),
  enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv(),
  verbose = FALSE
)

persistEvalQ(
  expr,
  retries = NVL(getOption("eval.retries"), 5),
  beforeRetry,
  envir = parent.frame(),
  enclos = if (is.list(envir) || is.pairlist(envir)) parent.frame() else baseenv(),
  verbose = FALSE
)
}
\arguments{
\item{expr}{an expression to be retried; note the difference
between \code{\link[=eval]{eval()}} and \code{\link[=evalq]{evalq()}}.}

\item{retries}{number of retries to make; defaults to
\code{"eval.retries"} option, or 5.}

\item{beforeRetry}{if given, an expression that will be evaluated
before each retry if the initial attempt fails; it is evaluated
in the same environment and with the same quoting semantics as
\code{expr}, but its errors are not handled.}

\item{envir, enclos}{see \code{\link[=eval]{eval()}}.}

\item{verbose}{Whether to output retries.}
}
\value{
Results of evaluating \code{expr}, including side-effects such
as variable assignments, if successful in \code{retries} retries.
}
\description{
A pair of functions paralleling \code{\link[=eval]{eval()}} and \code{\link[=evalq]{evalq()}} that make
multiple attempts at evaluating an expression, retrying on error up
to a specified number of attempts, and optionally evaluating
another expression before restarting.
}
\note{
If \code{expr} returns a \code{"try-error"} object (returned by
\code{\link[=try]{try()}}), it will be treated as an error. This behavior may
change in the future.
}
\examples{
x <- 0
persistEvalQ({if((x<-x+1)<3) stop("x < 3") else x},
             beforeRetry = {cat("Will try incrementing...\n")})

x <- 0
e <- quote(if((x<-x+1)<3) stop("x < 3") else x)
persistEval(e,
            beforeRetry = quote(cat("Will try incrementing...\n")))
}
