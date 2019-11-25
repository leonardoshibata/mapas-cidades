if(!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse)
pacman::p_load(osmdata)

coordenadas <- getbb("Maringa Brazil")

ruas <-
  coordenadas %>%
  opq() %>%
  add_osm_feature(key = "highway",
                  value = c(
                    "motorway",
                    "primary",
                    "secondary",
                    "tertiary",
                    "unclassified"
                    )) %>%
  osmdata_sf()

ruelas <- 
  coordenadas %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c(
                    "residential",
                    "living_street",
                    "service",
                    "footway"
                    )) %>%
  osmdata_sf()

rios <- 
  coordenadas %>% opq() %>%
  add_osm_feature(key = "waterway", value = "river") %>% osmdata_sf()

parques <- 
  coordenadas %>% opq %>%
  add_osm_feature(key = "leisure", value = "park") %>% osmdata_sf()


cut_x1 <- 0.11
cut_x2 <- -0.01
cut_y1 <- 0.08
cut_y2 <- -0.11

ggplot() +
  geom_sf(data = ruas$osm_lines,
          inherit.aes = FALSE,
          color = "#272727",
          size = .4,
          alpha = .8) +
  geom_sf(data = ruelas$osm_lines,
          inherit.aes = FALSE,
          color = "#272727",
          size = .3,
          alpha = .6) +
  geom_sf(data = rios$osm_lines,
          inherit.aes = FALSE,
          color = "#2B50AA",
          size = .3,
          alpha = .5) +
  geom_sf(data = parques$osm_polygons,
          inherit.aes = FALSE,
          color = "#169873",
          fill = "#169873",
          # size = .3,
          alpha = .6) +
  coord_sf(xlim = c(coordenadas[1,1]+cut_x1, coordenadas[1,2]+cut_x2), 
           ylim = c(coordenadas[2,1]+cut_y1, coordenadas[2,2]+cut_y2),
           expand = FALSE) +
  theme_void()




# black
ggplot() +
  geom_sf(data = ruas$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .4,
          alpha = .8) +
  geom_sf(data = ruelas$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .6) +
  geom_sf(data = rios$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(coordenadas[1,1]+cut_x1, coordenadas[1,2]+cut_x2), 
           ylim = c(coordenadas[2,1]+cut_y1, coordenadas[2,2]+cut_y2),
           expand = FALSE) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#282828")
  )
