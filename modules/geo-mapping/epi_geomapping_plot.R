library(leaflet)
library(sf)
library(htmltools)

#Import modules
source("modules/epidemiology/manage_epidata.R")

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


#plot.region.posrate.map <- plot_region_posrate_map(shp_path = shp_path, data = region_cmr_summary)

plot_cmr_map <- function(data, var_col = "received_samples", title_point="Received samples", number=0.1) {
  
  vals <- data[[var_col]]
  bins <- round(quantile(vals, probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE))
  
  labels <- lapply(bins, function(x) {
    radius <- sqrt(x) * 0.1
    paste0(
      "<div style='display: flex; align-items: center;'>",
      "<svg width='", radius*2, "' height='", radius*2, "'>",
      "<circle cx='", radius, "' cy='", radius, "' r='", radius, 
      "' stroke='black' stroke-width='1' fill='transparent' />",
      "</svg>",
      "<span style='margin-left:5px;'>", x, "</span>",
      "</div>"
    )
  })
  
  colors_bins <- rep("transparent", length(labels))
  
  cmr_map <- leaflet(data) %>%
    addTiles() %>%
    setView(lng = 12.343439, lat = 7.365302, zoom = 6) %>%
    addMiniMap(width = 150, height = 150) %>%
    addCircleMarkers(
      data = data %>% dplyr::filter(type == "Public"),
      lng = ~lat,
      lat = ~long,
      radius = as.formula(paste0("~sqrt(", var_col, ")*0.1")),
      color = "red",
      fillColor = "transparent",
      fillOpacity = 0.7,
      popup = ~paste(laboratory_name, "<br>", type, "<br>", var_col, ": ", get(var_col))
    ) %>%
    addCircleMarkers(
      data = data %>% dplyr::filter(type == "Private"),
      lng = ~lat,
      lat = ~long,
      radius = as.formula(paste0("~sqrt(", var_col, ")*",number)),
      color = "blue",
      fillColor = "transparent",
      fillOpacity = 0.7,
      popup = ~paste(laboratory_name, "<br>", type, "<br>", var_col, ": ", get(var_col))
    ) %>%
    addLegend(
      position = "bottomright",
      colors = c("red", "blue"),
      labels = c("Public", "Private"),
      title = "Laboratory type"
    ) %>%
    addLegend(
      position = "bottomleft",
      title = title_point,
      colors = colors_bins,
      labels = lapply(labels, HTML),
      opacity = 0
    )
  
  return(cmr_map)
}

#plot.region.posrate.map
#plot_cmr_map(lab_cmr_summary,"analysed_samples", "Analysed samples", 0.01)
#plot_cmr_map(lab_cmr_summary,"received_samples", "Received samples", 0.001)
#plot_cmr_map(lab_cmr_summary,"positive_samples", "Positive samples", 1)
#plot_cmr_map(lab_cmr_summary,"positive_rate", "Positive rate", 5)


