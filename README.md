# tile_grid_map
Tile Grid Map of several countries


Inspired by https://www.r-bloggers.com/the-tile-grid-map-for-canada/ I went looking for maps and found
https://gist.github.com/dannydb/9e8ca69eba06b976da55 for US
https://github.com/seankross/minimap for MX, CA, US
https://github.com/kristw/d3kit-gridmap for US, Thailand

Let's create some more maps.

```{r}
# ==== EXAMPLES OF TILE GRID MAPS ====

# put your data in here, 
# use the 'province' field for matching regions

somedata_df <- tibble(
  province = c("Hesse", "Berlin", "Saarland", "Hamburg"), 
  sightseeing = c("Staedel Museum", "Brandenburg Gate", "Schlossberghohlen Homburg", "Warehouse District")
);
tile_map_of_germany <- plot_tile_grid_map(country_data=somedata_df, 
                                          country_to_use="Germany", 
                                          column_name_for_fill="sightseeing",
                                          tile_grid_map=get_tile_grid_map("DACH"), 
                                          print_map=FALSE);
tile_map_of_germany

somedata_df <- tibble(
  province = c("Vienna", "Salzburg", "Tyrol", "Vorarlberg", "Lower Austria", "Upper Austria", "Styria", "Carinthia"), 
  fun_activity = c("concerts", "concerts", "skiing", "skiing", NA, NA, NA, NA),
  population_over_500k = c(1794770, 538258, 728537, NA, 1636287, 1436791, 1221014, 557371),
  population_over_1MM = c(1794770, NA, NA, NA, 1636287, 1436791, 1221014, NA)
);
plot_tile_grid_map(somedata_df, "Austria", "fun_activity")
plot_tile_grid_map(somedata_df, "Austria", "population_over_500k")
plot_tile_grid_map(somedata_df, "Austria", "population_over_1MM")

somedata_df <- tibble(
  province = c("Zürich", "Bern", "Vaud", "Aargau"), 
  population_over_500k = c(1463459, 1017483, 773407, 653675),
  population_over_1MM = c(1463459, 1017483, NA, NA)
);
plot_tile_grid_map(somedata_df, "Switzerland", "population_over_500k")
plot_tile_grid_map(somedata_df, "Switzerland", "population_over_1MM")
```
