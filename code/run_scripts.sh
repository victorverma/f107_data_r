#!/bin/bash

Rscript --vanilla download_raw_data.R
if [ $? -eq 0 ]; then
  Rscript --vanilla process_raw_data.R
else
  echo "Processing skipped because the download failed"
  exit 1
fi