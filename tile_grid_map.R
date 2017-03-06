library(tidyverse)

#  2 functions in here:
#    get_tile_grid_map_coordinates... creates tibble/data_frame for the DACH region in Europe
#    create_tile_grid_map... creates a tile grid map for a country
 
 # ==== CREATE TIBBLE WITH TILE GRID MAP COORDINATES FOR DACH REGION ====
#' @description location dataframe for Germany, Austria, and Switzerland,
#' arranged as tile grid map
#' @param region a string to select the region, only supports "DACH" for now;
#' default is "DACH"
#' @return a tibble with columns country, province, province_german, code, x, y
#' @author Gjeltema
#' @example get_tile_grid_map("DACH")
#' @note TO DO: need to align the 3 countries so that all can be plotted together
get_tile_grid_map_coordinates <- function(region="DACH"){
  if (region != "DACH") {  
    stop('Argument \"region\" only allows DACH for now (the default)')
  }
  
  tile_grid_map.austria <- tribble(
    ~country, ~province, ~province_german, ~code, ~x, ~y,
    "Austria", "Burgenland",    "Burgenland",       "Bgld.", 5,2,
    "Austria", "Carinthia",     "Kaernten",         "Ktn.",  4,1,
    "Austria", "Lower Austria", "Niederösterreich", "NÖ",    4,3,
    "Austria", "Salzburg",      "Salzburg",         "Sbg.",  3,2,
    "Austria", "Styria",        "Steiermark",       "Stmk.", 4,2,
    "Austria", "Tyrol",         "Tirol",            "T",     2,2,
    "Austria", "Upper Austria", "Oberösterreich",   "OÖ",    3,3,
    "Austria", "Vienna",        "Wien",             "W",     5,3,
    "Austria", "Vorarlberg",    "Vorarlberg",       "Vbg.",  1,2
  );
    
  tile_grid_map.germany <- tribble(
    ~country, ~province, ~province_german, ~code, ~x, ~y,
    "Germany", "Baden-Württemberg",      "Baden-Württemberg",      "BW", 2, 1,
    "Germany", "Bavaria",                "Bayern",                 "BY", 3, 1,
    "Germany", "Berlin",                 "Berlin",                 "BE", 4, 4,
    "Germany", "Brandenburg",            "Brandenburg",            "BB", 4, 3,
    "Germany", "Bremen",                 "Bremen",                 "HB", 2, 4,
    "Germany", "Hamburg",                "Hamburg",                "HH", 3, 4,
    "Germany", "Hesse",                  "Hessen",                 "HE", 2, 2,
    "Germany", "Mecklenburg-Vorpommern", "Mecklenburg-Vorpommern", "MV", 4, 5,
    "Germany", "Lower Saxony",           "Niedersachsen",          "NI", 2, 3,
    "Germany", "North Rhine-Westphalia", "Nordrhein-Westfalen",    "NW", 1, 3,
    "Germany", "Rhineland-Palatinate",   "Rheinland-Pfalz",        "RP", 1, 2,
    "Germany", "Saarland",               "Saarland",               "SL", 1, 1,
    "Germany", "Saxony",                 "Sachsen",                "SN", 4, 2,
    "Germany", "Saxony-Anhalt",          "Sachsen-Anhalt",         "ST", 3, 3,
    "Germany", "Schleswig-Holstein",     "Schleswig-Holstein",     "SH", 3, 5,
    "Germany", "Thuringia",              "Thüringen",              "TH", 3, 2
  );
  
  tile_grid_map.switzerland <- tribble(
    ~country, ~province, ~province_german, ~code, ~x, ~y,
    "Switzerland", "Aargau",                "Aargau",                 "AG", 3,5,
    "Switzerland", "Appenzell Ausserhoden", "Appenzell Ausserrhoden", "AR", 6,6,
    "Switzerland", "Appenzell Innerrhoden", "Appenzell Innerrhoden",  "AI", 6,5,
    "Switzerland", "Basel-Landschaft",      "Basel-Landschaft",       "BL", 2,6,
    "Switzerland", "Basel-Stadt",           "Basel-Stadt",            "BS", 2,7,
    "Switzerland", "Bern",                  "Bern",                   "BE", 2,3,
    "Switzerland", "Fribourg",              "Freiburg",               "FR", 1,3,
    "Switzerland", "Geneva",                "Genf",                   "GE", 0,2,
    "Switzerland", "Glarus",                "Glarus",                 "GL", 5,4,
    "Switzerland", "Graubünden",            "Graubünden",             "GR", 5,3,
    "Switzerland", "Jura",                  "Jura",                   "JU", 1,5,
    "Switzerland", "Luzern",                "Luzern",                 "LU", 2,4,
    "Switzerland", "Neuchâtel",             "Neuenburg",              "NE", 1,4,
    "Switzerland", "Nidwalden",             "Nidwalden",              "NW", 3,4,
    "Switzerland", "Obwalden",              "Obwalden",               "OW", 3,3,
    "Switzerland", "Schaffhausen",          "Schaffhausen",           "SH", 4,7,
    "Switzerland", "Schwyz",                "Schwyz",                 "SZ", 4,4,
    "Switzerland", "Solothurn",             "Solothurn",              "SO", 2,5,
    "Switzerland", "St. Gallen",            "St. Gallen",             "SG", 5,5,
    "Switzerland", "Thurgau",               "Thurgau",                "TG", 5,6,
    "Switzerland", "Ticino",                "Tessin",                 "TI", 4,2,
    "Switzerland", "Uri",                   "Uri",                    "UR", 4,3,
    "Switzerland", "Valais",                "Wallis",                 "VS", 2,2,
    "Switzerland", "Vaud",                  "Waadt",                  "VD", 1,2,
    "Switzerland", "Zug",                   "Zug",                    "ZG", 4,5,
    "Switzerland", "Zürich",                "Zürich",                 "ZH", 4,6
  );

  
  if (region == "DACH") {  
    tile_grid_map <- bind_rows(tile_grid_map.austria,
                               tile_grid_map.germany,
                               tile_grid_map.switzerland);
  } else { # empty tibble
    tile_grid_map <- tribble(
      ~country, ~province, ~province_german, ~code, ~x, ~y,
      character(0), character(0), character(0), character(0), integer(0), integer(0)
      )
  }
  
  return(tile_grid_map)
}


# ==== CREATE TILE GRID MAP OF ONE COUNTRY ====
#' @description create a plot of a single country as tile grid map
#' @param data the data to be applied to the map; must have a column with the 'province', must have other column named 'value'
#' @param column_name_for_fill  name of the column in 'data' to be plotted (a string)
#' @param country one country to be plotted, must be a string in
#' {Germany, Austria, Switzerland}
#' @param tile_grid_map a broader list of countries, provinces, 
#' x and y coordinates to plot the tile grid map
#' @return ggplot object (a tile grid map of the country)
#' @author Gjeltema
#' @example create_tile_grid_map(tibble(province=c("Hesse", "Berlin"), users=c(10, 4)),     
#'                            "Germany", "users", get_tile_grid_map_coordinates("DACH"));
#'          create_tile_grid_map(tibble(province=c("Zürich", "Bern"), 
#'                                    population_over_1MM=c(1463459, 1017483)),
#'                            "Switzerland", "population_over_1MM")
#'
create_tile_grid_map <- function(country_data, country_to_use, column_name_for_fill,
                               tile_grid_map=get_tile_grid_map_coordinates("DACH"), print_map=FALSE){
  # check input arguments
  if (is.null(country_data)) {  
    stop('Argument \"country_data\" required')
  }
  if (is.null(country_to_use) || !is.character(country_to_use))  {   
    stop('Argument \"country_to_use\" required')
  }
  if (is.null(column_name_for_fill) || !is.character(column_name_for_fill)) {  
    stop('Argument \"column_name_for_fill\" required')
  }
  if (!all(column_name_for_fill %in% colnames(country_data))) { # ensure the column exists
    stop('The column name ', column_name_for_fill, ' was not found')
  }
  if (!all(country_to_use %in% unique(tile_grid_map$country))) { # ensure the country exists
    stop('The country ', country_to_use, ' was not found')
  }
  if (!all(unique(country_data$province) %in% 
           unique(tile_grid_map %>% filter(country==country_to_use) %>% .$province))) { # ensure the provinces exists
    warning('Some provinces you listed in ', paste(country_data$province, collapse="|"), ' were not found in the country, please check for spelling')
  }

  gg_plot_country <- tile_grid_map %>% filter(country==country_to_use) %>%
    left_join(country_data, by="province") %>% 
    ggplot(aes(x, y)) + 
    # plot the country name as subtitle
    ggtitle(label="", subtitle=paste("Tile grid map of", country_to_use)) +
    geom_tile(aes_string(fill=column_name_for_fill)) + 
    # ensure white background and even spacing of tiles
    geom_text(aes(label=code), color="white") + 
    coord_fixed(ratio=1) + 
    theme(
      panel.background = element_blank(),
      panel.grid       = element_blank(), 
      axis.title       = element_blank(), 
      axis.text        = element_blank(), 
      axis.ticks       = element_blank());
  
  if (print_map) {print(gg_plot_country)}
  return(gg_plot_country)
}
