here::i_am("code/download_raw_data.R")

library(curl)
library(here)

curl_download(
  url = "ftp://ftp.seismo.nrcan.gc.ca/spaceweather/solar_flux/daily_flux_values/fluxtable.txt",
  destfile = here("data/raw/data.txt")
)