# Shiny Application Project: Visualization of SARS-CoV-2 Epidemiological and Genomic Data and Its Multiple Introductions in Cameroon

## Introduction

From the beginning of 2020 until 2024, Cameroon faced the Covid-19 pandemic caused by the SARS-CoV-2 virus. During this period, the Ministry of Public Health implemented a national response plan aimed at identifying, monitoring, and managing Covid-19 cases throughout the country. The operational coordination of this response was carried out by the **Public Health Emergency Operations Coordination Center (CCOUSP)**, a structure under the **Directorate for Disease, Epidemic and Pandemic Control (DLMEP)** and the **National Public Health Laboratory (LNSP)**.

The CCOUSP was organized into several specialized units, including logistics, data management, laboratory, risk communication, medical care, and epidemiological surveillance. For case identification, a **detection algorithm** was established, ranging from the identification of suspected cases (according to standardized definitions of symptoms and risk factors) to confirmation through molecular biology testing (RT-PCR). This system enabled not only the rapid detection of infections but also the monitoring of the epidemic’s evolution across the country.

This health crisis particularly highlighted the **central role of laboratories** in the surveillance system. Beyond diagnostic testing, several reference laboratories were progressively integrated into a national network, strengthening the country’s capacity for **epidemiological and genomic surveillance**. This led to the establishment of a more robust system, capable of monitoring not only the dynamics of viral spread but also the emergence of new Variants of Concern (VOC) and Variants of Interest (VOI).

In light of the above, an essential question arises: **what was the concrete contribution of these accredited laboratories in producing reliable and actionable information for the national Covid-19 response?**

To answer this, we propose combining SARS-CoV-2 epidemiological and genomic data to analyze the dynamics of the virus’s introduction and spread in Cameroon. This analysis will illustrate how laboratory data can inform public health decision-making.

Finally, to make these results accessible and interactive, we will develop a **Shiny visualization application**, facilitating data exploration by public health stakeholders, researchers, and policymakers.

------------------------------------------------------------------------

## Objectives

### 1. General Objective

To analyze the **dynamics of introduction and spread** of SARS-CoV-2 in Cameroon, through the joint integration of epidemiological and genomic data produced by accredited laboratories during the pandemic.

### 2. Specific Objectives

-   describe the **spatio-temporal dynamics of viral spread** across the different regions of the country,\
-   identify and characterize **introduction events** of SARS-CoV-2 and its variants (VOC and VOI) within the national territory,\
-   highlight the **local and inter-regional circulation** of viral lineages to better understand transmission chains,\
-   showcase these results through an **interactive Shiny application** enabling visualization and exploration of the data.

------------------------------------------------------------------------

## Methodology

The implementation of this project was carried out in several stages:

### 1. Data Collection and Cleaning

The data came from two main sources:

| Source | Description | Data Collected | Period | Location |
|----|----|----|----|----|
| **LNSP / Data Management Unit** | Information on case confirmations from accredited Covid-19 laboratories, compiled by the LNSP data management unit and the CCOUSP laboratory unit. | \- date of analysis<br>- region<br>- accredited laboratory<br>- number of cases tested (RT-PCR)<br>- number of positive cases (RT-PCR) | 2020–2024 | 10 regions of Cameroon |
| **GISAID** | Covid-19 WGS data shared by the scientific community. | \- complete SARS-CoV-2 sequences (fasta)<br>- collection date<br>- patient sex<br>- patient age<br>- symptoms<br>- geolocation (continent/country/region) | 2019–2024 | Worldwide |

The data were then **cleaned, harmonized, and standardized** to build a consolidated dataset.

------------------------------------------------------------------------

### 2. Epidemiological Study

Analysis of the **spatio-temporal dynamics** of the pandemic in Cameroon, including:

-   successive epidemic waves,\
-   predominant variants and lineages,\
-   geographic and temporal distribution.

Main tools:\
- **Nextclade** for variant and sub-lineage classification,\
- **tidyverse** and **plotly** for analyses and interactive visualizations.

Results:\
- **national epidemic curves**,\
- **dynamic maps** (spread and accredited laboratories),\
- **evolution of variants and sub-lineages** over time.

------------------------------------------------------------------------

### 3. Phylogenetic Analysis of Variants

Study of **genetic relatedness and similarity** between Cameroonian and international strains.

Tools:\
- **Mafft** (multiple alignment),\
- **IQTree** (maximum likelihood phylogeny),\
- **ggtree** (visualization).

------------------------------------------------------------------------

### 4. Introduction Analysis

Analysis of **SARS-CoV-2 introduction events** into Cameroon using **Treetime**, to:

-   estimate the **number of independent introductions**,\
-   identify the **probable sources** (countries/regions),\
-   describe **local spread** after introduction.

------------------------------------------------------------------------

### 5. Shiny Application

An **interactive Shiny application** was developed to:

-   visualize epidemic curves,\
-   explore **dynamic maps** (spread and laboratories),\
-   monitor the evolution of **variants and lineages**,\
-   consult **interactive phylogenetic trees**.

------------------------------------------------------------------------

## Results
