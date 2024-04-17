# Preliminary Mapbox Asian Basemap Test for Lab 7
By Cooper Komatsu

## Purpose
For my final project, I'm intending to create a Mapbox basemap that focuses on the Asian-American experience in the United States. Although I've collected a good bit of interesting, specific data, I thought it might be easiest to wrangle some census data and put it into Mapbox, since that's what I'm most familiar with. For this particular visualization, I simply worked with the percentage of residents of a particular area identifying as Asian alone.

## Methods
I used the tidycensus package in R with a Census API to find variables corresponding to the number of Asian-identifying residents, and the total population, of a given place. I got 2020 5-year ACS data, first at the county level for the entire county, and then at the tract level for California (loading tract-level data for the entire country was too difficult for my computer), for these two variables. Dividing the Asian population by the total population, I got the proportion of Asian residents. Then, for the California tract-level data, I subsetted the data to only include tracts with >35% Asian population. After writing that dataset, and the county-level Asian proportion, to shapefiles, I uploaded them into Mapbox. I played around with colors, labels, and transparencies, until I got something I was happy with. The county-level choropleth map in the background varies in darkness according to Asian proportion. Meanwhile, the red circles in California represent tracts with >35% Asian population, with larger circles having larger Asian populations. 

## Instructions
Download the attached file, unzip it, then upload it into Mapbox as a style. The basemap described above should be visible.

## Next Steps
I would certainly like to be able to get tract-level Asian population data for the whole country. I don't want to do it state-by-state, and there must be a better way (perhaps my computer could handle it by Census region?). However, this simple population census data should only comprise a portion of my final project. I'd like it to be more story-based, so perhaps this exploratory map could serve as a toggle-able base upon which the more immersive aspects are overlaid. In particular, I'm interested in investigating the locations of Chinatowns and other Asian ethnic neighborhoods in the US, as well as stories of Asian immigration to the US.
