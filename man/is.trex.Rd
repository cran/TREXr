% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is.trex.R
\name{is.trex}
\alias{is.trex}
\title{Testing and preparing input data}
\usage{
is.trex(data, tz = 'UTC', tz.force = FALSE, time.format = '\%m/\%d/\%y \%H:\%M:\%S',
  solar.time = TRUE, long.deg = 7.7459,
   ref.add = FALSE, df = FALSE)
}
\arguments{
\item{data}{A \code{data.frame} in either timestamp format or doy format.}

\item{tz}{Character string, indicates the time zone in which the measurements have been recorded.}

\item{tz.force}{Logical; if \code{TRUE}, the time zone is forced to "UTC" or re-labelled yet not shifted in time. "UTC" is required for internal processing (default = \code{FALSE}).}

\item{time.format}{Character string, indicates the format of the timestamp.}

\item{solar.time}{Logical; if \code{TRUE}, time is converted to solar time,
depending upon the location where the measurements have been taken.
 If \code{FALSE}, the output is provided in "UTC" (default = \code{FALSE}).}

\item{long.deg}{Numeric, longitude in decimal degrees East to perform the solar time
conversion. Only required when \code{solar.time=TRUE}.}

\item{ref.add}{Logical; if \code{TRUE}, additional probes provided within data
are considered. The \eqn{\Delta T} values are then corrected by subtracting
 the \eqn{\Delta T} measured between the reference probes from the \eqn{\Delta T}
 measured between the heated and unheated probe (default = \code{FALSE}).}

\item{df}{Logical; if \code{TRUE}, output is provided in a \code{data.frame} format with
a timestamp and a value (\eqn{\Delta T} or \eqn{\Delta V}) column.
If \code{FALSE}, output is provided as a \code{zoo} object (default = \code{FALSE}).}
}
\value{
A zoo object or data.frame in the appropriate format for other functionalities.
}
\description{
Tests if the structure of the input matches the requirements of \code{TREXr} functions
 and specifies the time zone. The input has to be presented in one of two different \code{data.frame} formats.
 i) Timestamp format: including a 1) timestamp of the measurements column (\code{character}), and
 2) value of \eqn{\Delta V} (or \eqn{\Delta T}; [\code{as.numeric}]). ii) DOY format: including a 1) year of measurements column \code{as.integer},
 2) day of the year (DOY) of measurement (\code{as.integer}), 3) hour of the measurement (\code{character}), and
 4) value of \eqn{\Delta V} (or \eqn{\Delta T}; [\code{as.numeric}]). TREXr functions are applied on time series obtained from a set of
 thermal dissipation probes. This includes the option where the thermal dissipation method (TDM) is
 used with only a reference and heating probe, or when including addition reference probes (see \code{ref.add}).
 These reference probe measurements can be added to the DOY or timestamp format in \eqn{\Delta V} (or \eqn{\Delta T}) (\code{as.numeric})
 labelled \code{ref1}, \code{ref2}, etc. (depending on the number of reference probes). For this function the following
 column names have to be present within the \code{data.frame}: "timestamp" or "year" & "doy" & "hour" = indicators
 of time and "value" = TDM measurements (option "ref1", "ref2, ..., refn = reference probes).
 After specifying the time zone (\code{tz}), one can select whether to standardize the temporal series to solar
 time (see \code{solar.time}) by providing the longitude in decimal degrees at which the measurements were
 obtained (in \code{long.deg}). All timestamps within the function are rounded to minute resolution and output can
 be either provided in a \code{zoo} format (df = \code{FALSE}) or \code{data.frame} (\code{df = TRUE}; default is \code{FALSE}).
 \strong{Note, that the output time series is always given in \code{UTC} time zone.}
}
\details{
To prevent errors occurring in subsequent \code{TREXr} functions, it is advised to run this function
 for checking the data structure and preparing it for further analyses. For the specific time zone see
 \url{https://en.wikipedia.org/wiki/List_of_tz_database_time_zones} or for formatting see \code{\link{OlsonNames}()}.
 The format of the timestamp has to be provided according to \url{https://www.stat.berkeley.edu/~s133/dates.html}.
 For the method behind the solar time conversion, see the solar package (\url{ https://CRAN.R-project.org/package=solaR}).
 The longitude has to be provided in positive decimal degrees for study sites East from the Greenwich meridian and negative for sites to the West.
}
\examples{
\donttest{
#validating and structuring example data
raw   <- example.data(type="doy")
input <- is.trex(raw,tz="GMT",time.format="\%H:\%M",
    solar.time=TRUE,long.deg=7.7459,
    ref.add=FALSE,df=FALSE)
head(raw)
str(input)
head(input)
plot(input)}
}
