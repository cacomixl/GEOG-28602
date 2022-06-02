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

Here are some highlights from the dot map: places that I was led to by my queries as well as places I discovered just by scrolling around the map.

### The Classics
![bayAsian](https://user-images.githubusercontent.com/104388190/171633497-de9807b1-7e45-4b15-874b-5263f9d0deb6.jpg)
![laAsian](https://user-images.githubusercontent.com/104388190/171633523-f7e352b4-9ca7-4d0f-98d9-e4ebf620c553.jpg)
![nycAsian](https://user-images.githubusercontent.com/104388190/171633536-7d436f19-7891-4f40-98ff-132e1f04dfa2.jpg)
![seattleAsian](https://user-images.githubusercontent.com/104388190/171633571-cb27533c-01af-4f63-a45a-f14d5caaa8b1.jpg)
![houstonAsian](https://user-images.githubusercontent.com/104388190/171633589-c8b1384f-b6cd-475d-bc23-01d2a3a52017.jpg)

### Exceptionally Asian Places
![mspAsian](https://user-images.githubusercontent.com/104388190/171633627-6de32c4d-9a59-4e36-bc5d-c154da2ecf12.jpg)
![napervilleAsian](https://user-images.githubusercontent.com/104388190/171633633-beacecff-7931-4d61-a3dd-a144c8ba5341.jpg)
![detroitAsian](https://user-images.githubusercontent.com/104388190/171633677-11c136a9-1009-494b-a04e-debafa7ba829.jpg)
![oahuAsian](https://user-images.githubusercontent.com/104388190/171633563-224c641d-def5-4d5a-9fd2-6e66b070175a.jpg)
![millbourneAsian](https://user-images.githubusercontent.com/104388190/171633693-3516f001-8b1e-4d36-a078-6dd57635c67d.jpg)

### Small Towns with Interesting Asian Populations
![kodiakAsian](https://user-images.githubusercontent.com/104388190/171633711-cf6fdaf5-1ad8-462c-a94e-c248fa4d817a.jpg)
![burasAsian](https://user-images.githubusercontent.com/104388190/171633750-24ff31ba-237a-48fa-80f5-5c0543671950.jpg)

## Discussion
One pattern that I noticed while looking at the map as a whole was that Asian-Americans were often clustered quite heavily around cities. However, I wasn't sure whether that was just because Americans in general tend to be clustered in cities, or Asian-Americans were particuraly prevalent in them. As it turns out (after some data wrangling, group-by-ing, and summarizing), Asian-Americans are indeed more concentrated in cities than American as a whole. Whereas Asian-Americans only make up 5.6% of the US population, they make up 9.7% of the population in counties labeled as "Large Central Metro". That percentage drops precipitously in less urban areas, with Asian-Americans comprising 2.2% of the population in "Small Metro" areas, 1.3% in "Micropolitan" areas, and only 0.6% in "Non-Core" areas.

![Asian Percents by Urban Code](https://user-images.githubusercontent.com/104388190/171604802-0c5d8163-d1ae-4694-916b-f1e437f59126.jpg)

This spatial distribution led me to wonder how urban/rural distribution varied by Asian ethnic group. After lots of typing in R, I got the table below. It revealed noticeable differences between Asian ethnic groups. Taiwanese-Americans were the most urban, with 51.5% living in "Large Central Metro" counties, closely followed by Chinese-Americans and Vietnamese-Americans. On the other end of the spectrum, Bhutanese, Hmong, and Laotian Americans all had "Large Central Metro" residence rates south of 30%, and higher residence in "Medium Metro" areas. There were also significant (>5% of national ethnic population) numbers of Burmese, Laotian, and Thai-Americans in rural "Non-Core" areas. Full data can be found below. That being said, there may be some effects of data collection--the fact that this analysis occurs at the county level--that show up here. Because counties in the Western US tend to be larger than those in the Midwest and the East, larger swaths of cities (e.g. the massive Los Angeles, Riverside, Clark, and Maricopa counties) are counted as "Large Central Metro," although large portions of them would be counted as suburban, or even exurban, if the counties were further subdivided. This means that Asian-American populations that are more concentrated in the West (often, East Asian populations) have a better cahnce of being counted as urban residents than those concentrated in the East (often, South Asian populations).

[cty_ethn_agg2.csv](https://github.com/cacomixl/GEOG-28602-Final/files/8822762/cty_ethn_agg2.csv)


## Conclusion

One thing I struggled with was that, whatever I did, dots for certain ethnic groups tended to get placed on top of other dots, creating an illusion (when viewed from far enough away) that those groups have larger, denser populations than they do. I heard that tippecanoe for Mapbox might be a solution for this, but I was struggling to even get tippecanoe on my laptop at all, so I decided to simply deal with the fact of the uneven distribution. In this future I would like to find a solution to this, but in the meantime I still think it looks pretty and tells a story! I also wasn't able to make a legend in Mapbox. I realized too late that this requires knowledge of Javascript, which I have no familiarity with, and a Mapbox.js platform that I didn't quite understand. This very much hampers the map reader's ability to figure out what's going on, and if not a legend I'd at least like to find a way to express the meaning of the map colors to any reader who's looking at the project.
