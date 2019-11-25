if(!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse)
pacman::p_load(osmdata)
pacman::p_load_gh("italocegatta/brmap")

coordenadas <- getbb("Brasilia Brazil")

ruas <-
  coordenadas %>% opq() %>%
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

limites <-
  brmap_municipio_simples %>%
  filter(municipio_nome == "Brasília")

cut_x1 <- 0.09
cut_x2 <- -0.13
cut_y1 <- 0.105
cut_y2 <- -0.09

ggplot() +
  # geom_sf(data = limites) +
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
  # geom_sf(data = parques$osm_polygons,
  #         inherit.aes = FALSE,
  #         color = "#169873",
  #         fill = "#169873",
  #         # size = .3,
  #         alpha = .6) +
  coord_sf(xlim = c(coordenadas[1,1]+cut_x1, coordenadas[1,2]+cut_x2), 
           ylim = c(coordenadas[2,1]+cut_y1, coordenadas[2,2]+cut_y2),
           expand = FALSE) +
  theme_void()