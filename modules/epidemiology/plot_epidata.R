library(plotly)
library(leaflet)
library(sf)



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
           plotly::layout(legend = list(orientation = "h",   # horizontal
                                x = 0.5,             # centré
                                xanchor = "center",
                                y = -0.1)))
}

plot.epicurve <- plot_epicurve(weekly_epidata)

plot_epicurve_region <- function(data, y_var, y_label){
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
          orientation = "h",  # horizontal
          x = 0.5,            # centré
          xanchor = "center",
          y = -0.1
        )
      )
  )
}

#plot_epicurve_region(region_cmr_epidata, "analysed_samples", "Analysed samples")

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


plot.epicurve.posrate <- plot_epicurve_posrate(weekly_epidata)

shp_path <- "data/shape_2022/region_cam_2022.shp"

plot_region_posrate_map <- function(shp_path, data){
  mtq <- st_read(shp_path)
  mtq <- mtq %>% 
    left_join(data, by = c("Code_RS"="code_rs"))
  mtq$positive_rate <- round(100*mtq$positive_samples/mtq$analysed_samples, 3)
  
  g <- leaflet() %>%
    addTiles() %>%
    addPolygons(
      data = mtq,
      fillColor = ~colorNumeric("YlOrRd", positive_rate)(positive_rate),  
      fillOpacity = 0.7,
      color = "white",  
      weight = 1,       
      popup = ~paste(Code_RS, "<br>", "Positive Rate (%):", positive_rate)  
    ) %>%
    addLegend(
      position = "bottomleft",         
      pal = colorNumeric("YlOrRd", mtq$positive_rate), 
      values = mtq$positive_rate,       
      title = "Positive Rate (%)",       
      labFormat = labelFormat(suffix = "%"),  
      opacity = 0.7           
    )
  
  return(g)
}


plot_region_posrate_map(shp_path = shp_path, data = region_cmr_summary)
