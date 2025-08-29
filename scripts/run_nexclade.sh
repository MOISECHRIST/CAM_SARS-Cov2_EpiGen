#!/bin/bash

#Download nexclade data base for sars-cov-2/wuhan-hu-1
nextclade dataset get \
 --name 'nextstrain/sars-cov-2/wuhan-hu-1' \
 --output-dir 'data/nextstrain_DB/sars-cov-2/wuhan-hu-1'

#And then run nexclade on Camerou=on's hcov sequences 
nextclade run --verbose \
 --input-dataset 'data/nextstrain_DB/sars-cov-2/wuhan-hu-1'\
 --output-csv 'data/gisaid_cmr/renamed.nextclade.results.csv'\
 data/gisaid_cmr/renamed.all.seqences.CMR.fast