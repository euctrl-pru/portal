library(dplyr)
library(readr)
library(stringr)
library(purrr)
library(lubridate)
library(tidyr)


ftype <- "hfe"

csvs <- list.files(
  here::here("static", "download", "csv"), 
  pattern = str_c(ftype,"_\\d{4}\\.csv\\.bz2"),
  full.names = TRUE)


get_hfe <- function(path) {
  col_types <- cols(
    .default = col_double(),
    YEAR = col_integer(),
    MONTH_NUM = col_integer(),
    MONTH_MON = col_character(),
    ENTRY_DATE = col_datetime(format = ""),
    ENTITY_NAME = col_character(),
    ENTITY_TYPE = col_character(),
    TYPE_MODEL = col_character(),
    DIST_FLOWN_KM = col_integer()
    #DIST_DIRECT_KM = col_integer(),
    #DIST_ACHIEVED_KM = col_integer()
  )
  
  read_csv(path, col_types = col_types) 
}

all <- csvs %>%
  map_dfr(get_hfe)

# rename 
all <- all %>% rename(
  date = ENTRY_DATE,
  yyyy = YEAR, mm = MONTH_NUM,
  entity_name = ENTITY_NAME, entity_type = ENTITY_TYPE,
  type_model = TYPE_MODEL,
  dist_flown_km = DIST_FLOWN_KM,
  dist_direct_km = DIST_DIRECT_KM,
  dist_achieved_km = DIST_ACHIEVED_KM) %>%
  mutate(
    dd = day(date)) %>%
  select(-MONTH_MON) %>%
  select(date, yyyy, mm, dd, everything()) 

all$dist_direct_km <- as.integer(all$dist_direct_km)
all$dist_achieved_km <- as.integer(all$dist_achieved_km)
