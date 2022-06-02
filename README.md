# GEOG-28602-Final
Work for my final project in GIS III: A Basemap for Asian America

## Goals
Broadly, I want to use Mapbox to create a map that portrays and grounds Asian-Americans. I want to use this map as a way of discovering elements of Asian-American cultures that I'd never been exposed to before. I intend for this to be an empowering project for myself, and perhaps other Asian-Americans, in terms of being visible in the cartographic tradition. Initially, I'd looked into creatinga complex web of Asian cultural stories and sites, but I've found that Mapbox (at least Mapbox Studio) is fairly limited in the number and type of data visualizations you can put in. It is good, however, at handling large quantities of data and making them look pretty, both of which feed in well to the idea of making a dot map of Asian-Americans in the US. After doing all of the heavy data wrangling, I hope to make it all look good, and represent all sorts of Asian-Americans, so that poeple who don't normally feel seen in the process of map-making do feel seen.


## Background
D’Ignazio and Klein’s Feminist Data Visualization paper provides a theoretical foundation for this research project. While Asian-Americans and women certainly face different issues, in society in general and in the field of data visualization, the ethos of critical cartography in viewing maps as “historically and culturally contingent documents” holds significance intersectionally (D’Ignazio 2). Maps (especially in America) have historically been created by and for a white audience, and this, consciously or unconsciously, affects the way in which maps are presented. This project aims to provide a preliminary investigation into what it looks like to intentionally portray an Asian-American perspective on the US, perhaps as a counter to the standardization of whiteness.

My intention in highlighting different Asian-American ethnic groups in this project is to counteract a common perception of Asian-American sameness: it is be wrong, and an erasure of cultural uniqueness, to claim a common experience among Asian-Americans, and the term itself is quite problematizable. That being said, there are some benefits to this grouping, mostly having to do with the external perception of Asian-Americans more generally. Those commonalities provide the basis for the overarching theme of the project.


## Data Sources
I used 5-year ACS average data from 2016-2020, acquired via the Census's Social Explorer page. In particular, I chose the “Asian Alone Or In Any Combination By Selected Groups” table, which had all of the data I needed. However, this was just a table, not spatial data, so I took the tract-level TIGER files for each state from the Census website. I also found urban/rural classifications for each US county from the CDC website. Lastly, I used the spData package to get a quick, well-organized shapefile of the entire US.

### Spatial Scale
I used tract-level data, as that is the smallest scale at which Asian-American ethnic data is available. Placing dots randomly within, say, a county, would not give specificity of the level of analysis where the reader could discern important spatial patterns. However, such a large volume of data can be overwhelming to someone wanting to perform analysis, so I used CDP-level searches to find leads toward interesting, story-worthy places. Moreover, urban/rural classification data seemed to only be available via the CDC on the county level, so I used that. I will discuss the limitations of this county-level data later.

### Temporal Scale
The census data comes from the 2016-2020 ACS 5-year estimate. I tried to get the most up-to-date data possible, and at first I tried to use 2020 census data, but it seems that ethnicity data for the 2020 census hasn't been published yet, so the ACS had to be sufficient. Regarding urban/rural classification, it seemed that the CDC had most recently published its classifications in 2013. However, I think this is okay, as the structure of a county uis nlikely to change that much in 10 years, especially in an era of relative stagnation in population, and 2013 data can be used to define the broadest of labels in 2022.

## Methods

I started by messing around with the tidycensus package in R, just to see what I could find. I realized that getting tract-level data for the entire country would be a long process, so instead I looked at counties and census-designated places to see what I could come up with. After loading, tidying, subsetting, and finding some interesting places I'd never considered in regarding to their Asian populations before, I decided to see how it would look like on a dot map (a form of visualization I'd found really compelling before.

In order to do the dot map, I referenced Jia Zhang's work at the Center for Spatial Research in making an Asian-American basemap (visible at https://medium.com/uncharted-singles/asian-american-dot-density-map-84271a4e68cd). In line with that tutorial, I grabbed data from the Census Social Explorer and the list of Census TIGER shapefiles. The TIGER files, in particular, were a pain to access, as I had to download, unzip, and upload each of 50 files individually, but once I did that, I was able to merge all of the states together in QGIS, then join the Social Explorer ethnicity data onto it. I diverged from Zhang's methods, however, in generating random dots for the basemap. For the random dot generation, I relied upon various online tutorials, the most prominent being that of Cornell GIS (at https://www.youtube.com/watch?v=TOY_7xKtTcU). I used the Dot Map plug-in to QGIS, took an input of numbers of points (people) in polygons (tracts), and outputted a proportional number of randomly-placed dots in each tract. I realized that I couldn't input the value for the entire Asian population, as then each Asian subgroup would not be distinct, so I created a shapefile for each one of the subgroups. Then, I ran each of them through the Dot Map plug-in. However, this wasn't enough, as Mapbox only takes one point dataset, so I marked each point according to subgroup then merged them into one big web of dots. After picking a subtle enough basemap that the dots would really stand out, I imported the dots.

One limitation of Mapbox was that I could only display seven groupings and colors of dots at a time. I'm not sure why they had this limit, but I did the best with what I had, grouping Asian-American communities (East Asian, Southeast Asian, South Asian) with similar languages and nearby homelands together, in addition to listing the four most common Asian-American ancestries (Chinese, Indian, Filipino, Vietnamese) as standalone groups. I then tried to give nearby natiolies similar colors, yet ones that would pop next to each other. Since I was using a dark basemap, I figured cyan, magenta, and yellow would be the most visible, so I assigned them to the three largest groups. Then, I issued slightly more subdued, yet still fully visible, colors to the rest of the divisions. After much trial and error with color, size, and opacity, I think I found a good balance.

I was not able to upload some of the files to the repo, as they were too big (even when zipped), but you can access the randomly placed dots used to make the Mapbox map (_All Asian Dots_), the tract-level shapefile of the entire US containing population counts for each Asian subgroup (_Full Asian Tracts_), and a QGIS file putting them together at the following Google Drive link: https://drive.google.com/drive/folders/1KMuf1umuicS5Gp1eg3B0XmReND1fsdE-?usp=sharing


## Results
The dot map can be viewed at https://api.mapbox.com/styles/v1/cacomixl/cl3w7e9qc00fb15l7geekmeke.html?title=view&access_token=pk.eyJ1IjoiY2Fjb21peGwiLCJhIjoiY2wyb2MydDhqMDRlZDNjbTh5bGJkNjZuYyJ9.Bb_yFaNZPLr63sO7AL_clQ&zoomwheel=true&fresh=true#5.71/33.124/-100.561/0/1

Here's a legend, for reference:
![LegendBlack](https://user-images.githubusercontent.com/104388190/171663302-0d19ba61-e5c2-4a8a-afdb-2f05586bb35b.jpg)

Here are some highlights from the dot map: places that I was led to by my queries as well as places I discovered just by scrolling around the map.

### The Classics
![bayAsian](https://user-images.githubusercontent.com/104388190/171633497-de9807b1-7e45-4b15-874b-5263f9d0deb6.jpg)
![laAsian](https://user-images.githubusercontent.com/104388190/171633523-f7e352b4-9ca7-4d0f-98d9-e4ebf620c553.jpg)
![nycAsian](https://user-images.githubusercontent.com/104388190/171633536-7d436f19-7891-4f40-98ff-132e1f04dfa2.jpg)

### Exceptionally Asian Places

![mspAsian](https://user-images.githubusercontent.com/104388190/171633627-6de32c4d-9a59-4e36-bc5d-c154da2ecf12.jpg)

The most remarkable part of the dot map of Minneapolis-St. Paul is just how orange it is, especially as compared to other cities. This indicates a high percentage of the _Other South Asian_ category, comprising Hmong, Laotian, Burmese, Cambodian, Malaysian, and Indonesian Americans. In particular, the Hmong population of Minneapolis-St. Paul is unparalleled, although the Burmese and Cambodian populations are quite high as well. Many Hmong people arrived in Minnesota as refugees from the wars in Indochina in the 1960s and 70s, and have since formed a vibrant community. St. Paul is home to the Hmong Village and HmongTown Marketplace shopping centers and the Hmong Cultural Center, as well as the birthplace of Hmong-American gymnast Sunisa Lee.

![detroitAsian](https://user-images.githubusercontent.com/104388190/171633677-11c136a9-1009-494b-a04e-debafa7ba829.jpg)

In the middle of Detroit, a city largely devoid of Asian-Americans in its center, lies a bright yellow-and-green splotch. This splotch is Hamtramck, Michigan, a historically Polish neighborhood that is now home to many Indians and Bangladeshis. Many Hamtramck residents are Muslim, and it is the first American city to have a city council composed of only Muslims. As such, the city has numerous mosques, as well as an annual Bangladeshi festival.

![napervilleAsian](https://user-images.githubusercontent.com/104388190/171635128-869d24a4-dda5-45e1-beff-1c369c31aecc.jpg)

Naperville, like many of Chicago's southwestern suburbs, is concentrated with a diverse group of Asian-Americans. It is one of the >20% Asian, >100,000 population cities in the US. It has large Indian, Chinese, and Filipino-American quarters, and this is reflected in the massive nearby Fox Valley mall. The mall contains delineated dining areas for Indian, Chinese, and Filipino food. At the same time, though, there is significant intermixing between these through large Asian-American populations: there are tracts in southeast Naperville where each of the three groups makes up between 15 and 25% of the Asian population.


### Small Towns with Interesting Asian Populations

![kodiakAsian](https://user-images.githubusercontent.com/104388190/171633711-cf6fdaf5-1ad8-462c-a94e-c248fa4d817a.jpg)

Kodiak was one of the places that popped up when I found all the >33% Asian-American places in the US: 2,781 of its 5,983 residents, or 46%, identify as such. I might've expected that Alaska would have a high Asian population due to its relative proximity, but I wouldn't have expected the largest Asian subgroup in Alaska to be Filipino! Kodiak is the prime example of this, with upwards of 35% of its population being Filipino. It is replete with two Asian markets, a Filipino barbeque shop, and a Filipino church within its small confines. Historically, Filipinos came to Alaska as seafarers in search of better-paying jobs, from cable-laying to gold-mining to fish-canning. Filipino-Alaska fish canners, known as _Alaskeros_, were subject to discriminatory and racist treatment at work, and formed a union, the first of its kind, to call for better working conditions

![burasAsian](https://user-images.githubusercontent.com/104388190/171633750-24ff31ba-237a-48fa-80f5-5c0543671950.jpg)

Buras also popped up on the list of >33% Asian-American places, being 50% percent Asian-American, and I was even more surprised about Buras than I was about Kodiak. Because the town was so small, I thought it might even be a mistake, but the evidence seems to back the numbers up. Buras has a large population of Cambodian and Vietnamese fisherpeople who withstood the horrors of Hurricane Katrina. Buras is also home to a Vietnamese market and a Chinese restaurant, significant for a town of less than 1,000. 

![millbourneAsian](https://user-images.githubusercontent.com/104388190/171635095-e0559bbe-c7d6-4b6d-a61a-ef6c65a602d2.jpg)

Millbourne may be smack dab near the center of Philadelphia, but it counts as its own census-designated place, and because of that, it showed up on my list, with a whopping 67% of residents being Asian-American. This tiny sliver of 1,258  people is the home of the Philadelphia Sikhi Society, as well as a Bangladeshi grocery store, and the bright green and yellow dots just West of Downtown suggest that Millbourne is a hub for South Asian people in the Philadelphia area. Previously a Korean neighborhood, and with one Korean restaurant open in the town, Millbourne has transformed into a Punjabi and Bangladeshi center since the turn of the century.

## Discussion
One pattern that I noticed while looking at the map as a whole was that Asian-Americans were often clustered quite heavily around cities. However, I wasn't sure whether that was just because Americans in general tend to be clustered in cities, or Asian-Americans were particuraly prevalent in them. As it turns out (after some data wrangling, group-by-ing, and summarizing), Asian-Americans are indeed more concentrated in cities than American as a whole. Whereas Asian-Americans only make up 5.6% of the US population, they make up 9.7% of the population in counties labeled as "Large Central Metro". That percentage drops precipitously in less urban areas, with Asian-Americans comprising 2.2% of the population in "Small Metro" areas, 1.3% in "Micropolitan" areas, and only 0.6% in "Non-Core" areas.

![Asian Percents by Urban Code](https://user-images.githubusercontent.com/104388190/171604802-0c5d8163-d1ae-4694-916b-f1e437f59126.jpg)

This spatial distribution led me to wonder how urban/rural distribution varied by Asian ethnic group. After lots of typing in R, I got the table below. It revealed noticeable differences between Asian ethnic groups. Taiwanese-Americans were the most urban, with 51.5% living in "Large Central Metro" counties, closely followed by Chinese-Americans and Vietnamese-Americans. On the other end of the spectrum, Bhutanese, Hmong, and Laotian Americans all had "Large Central Metro" residence rates south of 30%, and higher residence in "Medium Metro" areas. There were also significant (>5% of national ethnic population) numbers of Burmese, Laotian, and Thai-Americans in rural "Non-Core" areas. Full data can be found below. That being said, there may be some effects of data collection--the fact that this analysis occurs at the county level--that show up here. Because counties in the Western US tend to be larger than those in the Midwest and the East, larger swaths of cities (e.g. the massive Los Angeles, Riverside, Clark, and Maricopa counties) are counted as "Large Central Metro," although large portions of them would be counted as suburban, or even exurban, if the counties were further subdivided. This means that Asian-American populations that are more concentrated in the West (often, East Asian populations) have a better cahnce of being counted as urban residents than those concentrated in the East (often, South Asian populations).

[cty_ethn_agg2.csv](https://github.com/cacomixl/GEOG-28602-Final/files/8822762/cty_ethn_agg2.csv)


## Conclusion

This was a really fun exercise for me in visualization!

One thing I struggled with was that, whatever I did, dots for certain ethnic groups tended to get placed on top of other dots, creating an illusion (when viewed from far enough away) that those groups have larger, denser populations than they do. I heard that tippecanoe for Mapbox might be a solution for this, but I was struggling to even get tippecanoe on my laptop at all, so I decided to simply deal with the fact of the uneven distribution. In this future I would like to find a solution to this, but in the meantime I still think it looks pretty and tells a story! I also wasn't able to make a legend in Mapbox. I realized too late that this requires knowledge of Javascript, which I have no familiarity with, and a Mapbox.js platform that I didn't quite understand. This very much hampers the map reader's ability to figure out what's going on, and if not a legend I'd at least like to find a way to express the meaning of the map colors to any reader who's looking at the project.
