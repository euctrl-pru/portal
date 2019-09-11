#!/usr/bin/env Rscript

"Export trajectories to file in SO6 format.

Usage: export_trajectories [-h] [-o FILE] -m MODEL WEF TIL

  -h --help               show this help text
  -m MODEL, --model=MODEL the MODEL of trajectory; it can be one of FTFM, CTFM, RTFM, EVENT, CPF
  -o FILE, --output=FILE  the output filename where to save the data, [default: trj_<MODEL>_<WEF>_<TIL>.so6]

Arguments:
  WEF  LOBT date[time] from when to export data, format 'YYYY-MM-DD [HH:MM:SS]'
  TIL  LOBT date[time] till when to export data, format 'YYYY-MM-DD [HH:MM:SS]' (non-inclusive)
" -> doc

suppressWarnings(suppressMessages(library(docopt)))

# retrieve the command-line arguments
opts <- docopt(doc)

models <- c("FTFM", "CTFM", "RTFM", "EVENT", "CPF")

if (!(opts$model %in% models)) {
  cat("Error: incorrect MODEL, it must be one of", paste0(types, collapse = ", "), "\n")
  cat(doc, "\n")
  q(status = -1)
} else {
  model <- opts$model
}

suppressWarnings(suppressMessages(library(parsedate)))
suppressWarnings(suppressMessages(library(purrr)))
suppressWarnings(suppressMessages(library(stringr)))
suppressWarnings(suppressMessages(library(trrrj)))
suppressWarnings(suppressMessages(library(readr)))

safe_ymd <- purrr::safely(parsedate::parse_date)
wef <- safe_ymd(opts$WEF)
til <- safe_ymd(opts$TIL)

if (is.null(wef$result) || is.null(til$result)) {
  cat("Error: invalid WEF and/or TIL, it must be in YYYY-MM-DD format", "\n")
  cat(doc, "\n")
  q(status = -1)
} else {
  wef_ora <- format(wef$result, "%Y-%m-%dT%H:%M:%SZ")
  til_ora <- format(til$result, "%Y-%m-%dT%H:%M:%SZ")
  wef <- format(wef$result, "%Y-%m-%dT%H%M%SZ")
  til <- format(til$result, "%Y-%m-%dT%H%M%SZ")
}


if (model == "EVENT") {
  df <- trrrj::export_event_so6(wef_ora, til_ora)
} else {
  df <- trrrj::export_allft_so6(wef_ora, til_ora, model)
}

if (opts$output == "trj_<MODEL>_<WEF>_<TIL>.so6") {
  fn <- here::here(str_c("trj_", model, "_", wef, "_", til, ".so6"))
} else {
  fn <- opts$output
}

readr::write_delim(df, fn, col_names = FALSE, na = "")

