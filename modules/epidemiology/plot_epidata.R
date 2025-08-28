library(plotly)


#Import modules
source("modules/epidemiology/manage_epidata.R")

plot_epicurve <- function(data){
  g <- ggplot(data) +
    geom_bar(aes(x=epi_week, y=analysed_samples, fill="Analysed samples"),stat = "identity") +
    geom_bar(aes(x=epi_week, y=positive_samples, fill="Positive samples"),stat = "identity") +
    theme(legend.position = "top",
      axis.text.x = element_text(angle = 90, hjust = 1, , size = 5) 
    )+
    labs(
      y = "Values",
      x = "Epi Week",
      fill = "Legende"
    )
  return(ggplotly(g) %>%
           plotly::layout(legend = list(orientation = "h",   
                                x = 0.5,             
                                xanchor = "center",
                                y = -0.1)))
}

#plot.epicurve <- plot_epicurve(weekly_epidata)

plot_epicurve_region <- function(data, y_var, y_label, min_epiweek = "2020-42", max_epiweek = "2023-9"){
  g <- ggplot(data, aes(x = epi_week, y = .data[[y_var]], fill = region)) +
    geom_bar(stat = 'identity') +
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1, size = 5)
    ) +
    labs(
      y = y_label,
      x = "Epi Week",
      fill = "Region"
    )
  
  return(
    ggplotly(g) %>%
      plotly::layout(
        legend = list(
          orientation = "h",  
          x = 0.5,            
          xanchor = "center",
          y = -0.1
        )
      )
  )
}

plot_epicurve_posrate <- function(data){
  g <- ggplot(data, aes(x = epi_week, y = positive_rate)) +
    geom_line(colour = "blue", group = 1) +
    geom_point(shape = 21, fill = "white", colour = "red", size = 1) +
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1, size = 5)
    ) +
    labs(
      y = "Positive rate",
      x = "Epi Week"
    )
  return(ggplotly(g))
}


#plot.epicurve.posrate <- plot_epicurve_posrate(weekly_epidata)

#plot.epicurve
#plot_epicurve_region(region_cmr_epidata, "analysed_samples", "Analysed samples")
#plot_epicurve_region(region_cmr_epidata, "received_samples", "Received samples")
#plot_epicurve_region(region_cmr_epidata, "positive_samples", "Positive samples")
#plot_epicurve_region(region_cmr_epidata, "positive_rate", "Positive rate")
#plot.epicurve.posrate






