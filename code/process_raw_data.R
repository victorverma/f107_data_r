here::i_am("code/process_raw_data.R")

# Load packages -----------------------------------------------------------

library(here)
library(tidyverse)

# Process the data --------------------------------------------------------

f107_tbl <- read_fwf(
  here("data/raw/data.txt"),
  col_positions = fwf_cols(
    date = c(1, 10),
    time = c(13, 22),
    julian = c(25, 36),
    carrington = c(39, 52),
    obsflux = c(55, 65),
    adjflux = c(68, 78),
    ursi = c(81, 90)
  ),
  col_types = "ccddddd",
  skip = 2
) %>%
  mutate(date_time = as_datetime(str_c(date, time))) %>%
  relocate(date_time, .before = 1) %>%
  select(!c(date, time))

f107_summary_tbl <- f107_tbl %>%
  mutate(dt = date(date_time)) %>%
  group_by(dt) %>%
  summarize(adjflux = max(adjflux)) %>%
  complete(dt = full_seq(dt, period = 1))

# Save the processed data -------------------------------------------------

save(
  f107_tbl, f107_summary_tbl, file = here("data/processed/tbls.RData")
)