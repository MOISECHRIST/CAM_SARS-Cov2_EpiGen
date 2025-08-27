library(rio)
library(conflicted)
library(tidyverse)
library(janitor)


#In this module, I will :
# -> Import epidemiology data,
# -> Proceed to data cleaning, and
# -> Perform all data transformation and aggregation 

#Function to compute positive rate 
positive.rate <- function(nb_analysed, nb_positive){
  return(if_else(nb_analysed==0, NA,
                 100*nb_positive/nb_analysed))
}

#Path to epi-data
path_to_data <- "data/epidata_cmr/pcr_compiler_202508261454.csv"

#Import and clean epi-data 
import.epidata <- function(path_to_epidata) {
  cmr_epidata <- import(path_to_epidata) %>%
    clean_names() |>
    mutate(positive_rate = positive.rate(total_analysed_sample, total_positives_sample),
           laboratory_name = case_match(laboratory_name,
                                        "cpc yaoundé"~"CPC Yaoundé",
                                        "cpc annexe garoua" ~ "CPC Annexe Garoua",
                                        "lnsp" ~ "LNSP",
                                        "cremer" ~ "CREMER",
                                        "cresar" ~ "CRESAR",
                                        "circb" ~ "CIRCB",
                                        "trl bamenda" ~ "TRL Bamenda",
                                        .default = str_to_title(laboratory_name)),
           region = str_to_title(region)) 
  return(cmr_epidata)
}


all_cmr_epidata <- import.epidata(path_to_epidata = path_to_data)

#Summarise epidata per epi-week and compute positive_rate
weekly.epidata <- function(all_cmr_epidata){
  tmp <- all_cmr_epidata |>
    group_by(year, epi_week)|>
    summarise(received_samples = sum(total_received_sample, na.rm = T), 
              analysed_samples = sum(total_analysed_sample, na.rm = T),
              positive_samples = sum(total_positives_sample, na.rm = T),
              positive_rate = positive.rate(analysed_samples, positive_samples),
              .groups = "drop")
  
  return( tmp |> mutate(epi_week = paste(year, epi_week, sep = "-")))
}

weekly_epidata <- weekly.epidata(all_cmr_epidata)

#Summarise epidata per epi-week, region and compute positive_rate
weekly.region.epidata <- function(all_cmr_epidata){
  return(all_cmr_epidata |>
           group_by(year, epi_week, region)|>
           summarise(received_samples = sum(total_received_sample, na.rm = T), 
                     analysed_samples = sum(total_analysed_sample, na.rm = T),
                     positive_samples = sum(total_positives_sample, na.rm = T),
                     positive_rate = positive.rate(analysed_samples, positive_samples),
                     .groups = "drop") |> mutate(epi_week = paste(year, epi_week, sep = "-")))
}

region_cmr_epidata <- weekly.region.epidata(all_cmr_epidata)

#Summarise epidata per epi-week, lab and compute positive_rate
weekly.lab.epidata <- function(all_cmr_epidata){
  return(all_cmr_epidata |>
           group_by(year, epi_week, laboratory_name)|>
           summarise(received_samples = sum(total_received_sample, na.rm = T), 
                     analysed_samples = sum(total_analysed_sample, na.rm = T),
                     positive_samples = sum(total_positives_sample, na.rm = T),
                     positive_rate = positive.rate(analysed_samples, positive_samples),
                     .groups = "drop"))
}

lab_cmr_epidata <- weekly.lab.epidata(all_cmr_epidata)


#Summarise epidata per lab and compute positive_rate
summary.lab.epidata <- function(all_cmr_epidata){
  
  lab_summary <- all_cmr_epidata |>
    group_by(region, laboratory_name) |>
    summarise(
      received_samples  = sum(total_received_sample, na.rm = TRUE),
      analysed_samples  = sum(total_analysed_sample, na.rm = TRUE),
      positive_samples  = sum(total_positives_sample, na.rm = TRUE),
      positive_rate     = positive.rate(analysed_samples, positive_samples),
      .groups = "drop"
    )
  
  lab_summary <- lab_summary |>
    mutate(laboratory_name = factor(laboratory_name, levels = unique(laboratory_name)))
  
  return(lab_summary)
}

lab_cmr_summary <- summary.lab.epidata(all_cmr_epidata)

#Summarise epidata per region and compute positive_rate
summary.region.epidata <- function(all_cmr_epidata){
  
  region_summary <- all_cmr_epidata |>
    group_by(region) |>
    summarise(
      received_samples  = sum(total_received_sample, na.rm = TRUE),
      analysed_samples  = sum(total_analysed_sample, na.rm = TRUE),
      positive_samples  = sum(total_positives_sample, na.rm = TRUE),
      positive_rate     = positive.rate(analysed_samples, positive_samples),
      .groups = "drop"
    ) |> 
    mutate(code_rs = c( "ADA", "CEN", "EST", "EXT", "LIT", "NOR", "NOW", "OUE", "SUW", "SUD"))
  
  return(region_summary)
}

region_cmr_summary <- summary.region.epidata(all_cmr_epidata)
