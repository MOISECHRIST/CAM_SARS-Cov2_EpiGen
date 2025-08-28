library(rio)
library(conflicted)
library(tidyverse)
library(janitor)

path_to_cmr_gisaid_metadata <- "data/gisaid_cmr/all.metadata.CMR.tsv"

cmr_gisaid_metadata <- import(path_to_cmr_gisaid_metadata) |>
  clean_names() 


cmr_gisaid_metadata %>%
  select(strain, gisaid_epi_isl) %>%
  rename(old_name = strain,
         new_name = gisaid_epi_isl) %>%
  rio::export("data/gisaid_cmr/rename_sequences.csv")





