
# Step 1. load the neighborhoods of merida ####
addresses <- paste(c("Amalia",
                     "Centro",
                     "Juan Pablo",
                     "Los Reyes",
                     "Dzodzil",
                     "Pacabtun",
                     "San Jose Tecoh",
                     "Carranza",
                     "Pensiones",
                     "Brisas",
                     "Vergel II",
                     "Mulsay",
                     "Vista Alegre",
                     "Garcia Gineres",
                     "Benito Juarez",
                     "Cinco colonias",
                     "Emiliano Zapata",
                     "Melchor Ocampo",
                     "Obrera",
                     "Bojorquez",
                     "Portes Gil"), 
                   "Merida, Yucatan, Mexico",
                   sep = ", ")

denhotspots::geocoden(infile = "col_mer")

col_mer_geo <- tibble::tibble(colonias = c("Amalia",
                                           "Centro",
                                           "Juan Pablo",
                                           "Los Reyes",
                                           "Dzodzil",
                                           "Pacabtun",
                                           "San Jose Tecoh",
                                           "Carranza",
                                           "Pensiones",
                                           "Brisas",
                                           "Vergel II",
                                           "Mulsay",
                                           "Vista Alegre",
                                           "Garcia Gineres",
                                           "Benito Juarez",
                                           "Cinco colonias",
                                           "Emiliano Zapata",
                                           "Melchor Ocampo",
                                           "Obrera",
                                           "Bojorquez",
                                           "Portes Gil"),
                              longitud = z$long,
                              latitud = z$lat) |>
    sf::st_as_sf(coords = c("longitud", "latitud"),
                 crs = 4326)

# Step 2. load the neighborhoods of tapachula ####
load("~/Library/CloudStorage/Dropbox/projects/hotspots_insecticide_resistance/3.RData/santoyo_et_al_2021.RData")

col_tap_geo <- t2 |>
    sf::st_as_sf(coords = c("longitude", "latitude"),
                 crs = 4326)

# Step 3. load the hotspots 
load("/Users/fdzul/Library/CloudStorage/Dropbox/hotspots_2022/8.RData/cases_hotspots_agebs19.RData")


# Step 4. map merida ####
cases_hotspots_agebs19 |>
    dplyr::filter(loc == "Merida") |>
denhotspots::staticmap_intensity(pal = rcartocolor::carto_pal,
                                 pal_name = TRUE,
                                 name = "OrYel",
                                 breaks = 1,
                                 dir_pal = -1,
                                 x_leg = 0.8,
                                 y_leg = 0.07,
                                 ageb = TRUE) +
    ggspatial::annotation_scale(style = "ticks") +
    ggspatial::annotation_north_arrow(location = "tr",
                                      height = ggplot2::unit(1, "cm"),
                                      width = ggplot2::unit(1, "cm")) +
    ggplot2::geom_sf(data = col_mer_geo)



# Step 5. map tapachula ###
cases_hotspots_agebs19 |>
    dplyr::filter(loc == "Tapachula de Córdova y Ordóñez") |>
    denhotspots::staticmap_intensity(pal = rcartocolor::carto_pal,
                                     pal_name = TRUE,
                                     name = "OrYel",
                                     breaks = 1,
                                     dir_pal = -1,
                                     x_leg = 0.8,
                                     y_leg = 0.07,
                                     ageb = TRUE) +
    ggspatial::annotation_scale(style = "ticks") +
    ggspatial::annotation_north_arrow(location = "tr",
                                      height = ggplot2::unit(1, "cm"),
                                      width = ggplot2::unit(1, "cm")) +
    ggplot2::geom_sf(data = col_tap_geo)
