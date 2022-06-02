# required packages
library(tidycensus)
library(tmap)
library(sf)
library(dplyr)
library(tidyverse)
library(spData)

# get all places that are over 1/3 asian
asn_place <- get_acs(geography = "place", variables = c(asnPop = "B02015_001", totPop = "B01003_001"), year = 2020, geometry = TRUE) %>%
  select(GEOID, NAME, variable, estimate, geometry) %>% 
  spread(variable, estimate) %>%
  mutate(asnPct = asnPop/totPop) %>%
  subset(asnPct > 0.33)

head(big_asn_place)

# get all places over 100,000 people that are over 1/5 asian
big_asn_place <- get_acs(geography = "place", variables = c(asnPop = "B02015_001", totPop = "B01003_001"), year = 2020, geometry = TRUE) %>%
  select(GEOID, NAME, variable, estimate, geometry) %>% 
  spread(variable, estimate) %>%
  mutate(asnPct = asnPop/totPop) %>%
  subset(asnPct > 0.2) %>%
  subset(totPop > 100000)


# loading all of the variables needed for dot map plotting. did most of the work in QGIS and online, though.

#View(load_variables(year = 2020, "acs5"))
asn_pct <- get_acs(geography = "tract", variables = c(asnPop = "B02015_001", 
                                                      indiPop = "B02015_002", 
                                                      bangPop = "B02015_003", 
                                                      bhutPop = "B02015_004",
                                                      burmPop = "B02015_005",
                                                      cambPop = "B02015_006",
                                                      chinPop = "B02015_007",
                                                      filiPop = "B02015_008",
                                                      hmonPop = "B02015_009",
                                                      indoPop = "B02015_010",
                                                      japaPop = "B02015_011",
                                                      korePop = "B02015_012",
                                                      laotPop = "B02015_013",
                                                      malaPop = "B02015_014",
                                                      mongPop = "B02015_015",
                                                      nepaPop = "B02015_016",
                                                      okinPop = "B02015_017",
                                                      pakiPop = "B02015_018",
                                                      srilPop = "B02015_019",
                                                      taiwPop = "B02015_020",
                                                      thaiPop = "B02015_021",
                                                      vietPop = "B02015_022",
                                                      othsPop = "B02015_023",
                                                      othnPop = "B02015_024",
                                                      twomPop = "B02015_025",
                                                      wasiPop = "C02003_015",
                                                      totPop = "B02001_001"),
                   year = 2020, geometry = TRUE) %>%
  select(GEOID, variable, estimate, geometry) %>% 
  spread(variable, estimate) %>% 
  mutate(asnPct = asnPop/totPop, 
         indiPct = indiPop/totPop, 
         bangPct = bangPop/totPop, 
         bhutPct = bhutPop/totPop, 
         burmPct = burmPop/totPop, 
         cambPct = cambPop/totPop, 
         chinPct = chinPop/totPop, 
         filiPct = filiPop/totPop, 
         hmonPct = hmonPop/totPop, 
         indoPct = indoPop/totPop, 
         japaPct = japaPop/totPop, 
         korePct = korePop/totPop, 
         laotPct = laotPop/totPop, 
         malaPct = malaPop/totPop, 
         mongPct = mongPop/totPop, 
         nepaPct = nepaPop/totPop, 
         okinPct = okinPop/totPop, 
         pakiPct = pakiPop/totPop, 
         srilPct = srilPop/totPop, 
         taiwPct = taiwPop/totPop, 
         thaiPct = thaiPop/totPop,
         vietPct = vietPop/totPop, 
         othsPct = othsPop/totPop, 
         othnPct = othnPop/totPop,
         twomPct = towmPop/totPop,
         wasiPct = wasiPop/totPop)



# creating a shapefile by joining county-level urban classification data with census geometries

usa <- world %>%
  filter(iso_a2 == "US")
usCounties <- get_acs(geography = "county", variables = c(asnPop = "B02015_001", 
                                                          indiPop = "B02015_002", 
                                                          bangPop = "B02015_003", 
                                                          bhutPop = "B02015_004",
                                                          burmPop = "B02015_005",
                                                          cambPop = "B02015_006",
                                                          chinPop = "B02015_007",
                                                          filiPop = "B02015_008",
                                                          hmonPop = "B02015_009",
                                                          indoPop = "B02015_010",
                                                          japaPop = "B02015_011",
                                                          korePop = "B02015_012",
                                                          laotPop = "B02015_013",
                                                          malaPop = "B02015_014",
                                                          mongPop = "B02015_015",
                                                          nepaPop = "B02015_016",
                                                          okinPop = "B02015_017",
                                                          pakiPop = "B02015_018",
                                                          srilPop = "B02015_019",
                                                          taiwPop = "B02015_020",
                                                          thaiPop = "B02015_021",
                                                          vietPop = "B02015_022",
                                                          othsPop = "B02015_023",
                                                          othnPop = "B02015_024",
                                                          twomPop = "B02015_025",
                                                          wasiPop = "C02003_015",
                                                          totPop = "B02001_001"), year = 2020, geometry = TRUE) %>%
  select(GEOID, variable, estimate, geometry) %>% 
  spread(variable, estimate)
urCodes <- read_csv("~/NCHSURCodes2013.csv")
urCodes <- rename(urCodes, GEOID = "FIPS code")
urCodes <- rename(urCodes, code2013 = "2013 code")
usCounties$GEOID <- as.numeric(usCounties$GEOID)
urCodesGeom <- right_join(x = urCodes, y = usCounties, by = "GEOID")
urCodesGeom <- st_as_sf(urCodesGeom)
head(urCodesGeom)


# finding total asian population table in different urban classifications

cty_urb_agg = urCodesGeom %>% 
  st_drop_geometry() %>%                      # drop the geometry for speed
  dplyr::select(code2013, asnPop, totPop) %>% # subset the columns of interest  
  group_by(code2013) %>%                     # group by urban code and summarize
  summarize(AsnPop = sum(asnPop, na.rm = TRUE), TotPop = sum(totPop, na.rm = TRUE)) %>%
  mutate(AsnPct = round(AsnPop / TotPop * 10000)/100) %>%     # calculate asian population percentage
  arrange(desc(AsnPct)) # arrange in descending order

# finding asian ethnic populations in different urban classifications
cty_ethn_agg = urCodesGeom %>% 
  st_drop_geometry() %>%                      # drop the geometry for speed
  dplyr::select(code2013, asnPop:wasiPop) %>% # subset the columns of interest  
  group_by(code2013) %>%                     # group by urban code and summarize
  summarize(TotPop = sum(totPop, na.rm = TRUE),
            AsnPop = sum(asnPop, na.rm = TRUE),
            IndiPop = sum(indiPop, na.rm = TRUE),
            BangPop = sum(bangPop, na.rm = TRUE),
            BhutPop = sum(bhutPop, na.rm = TRUE),
            BurmPop = sum(burmPop, na.rm = TRUE),
            CambPop = sum(cambPop, na.rm = TRUE),
            ChinPop = sum(chinPop, na.rm = TRUE),
            FiliPop = sum(filiPop, na.rm = TRUE),
            HmonPop = sum(hmonPop, na.rm = TRUE),
            IndoPop = sum(indoPop, na.rm = TRUE),
            JapaPop = sum(japaPop, na.rm = TRUE),
            KorePop = sum(korePop, na.rm = TRUE),
            LaotPop = sum(laotPop, na.rm = TRUE),
            MalaPop = sum(malaPop, na.rm = TRUE),
            MongPop = sum(mongPop, na.rm = TRUE),
            NepaPop = sum(nepaPop, na.rm = TRUE),
            OkinPop = sum(okinPop, na.rm = TRUE),
            PakiPop = sum(pakiPop, na.rm = TRUE),
            SrilPop = sum(srilPop, na.rm = TRUE),
            TaiwPop = sum(taiwPop, na.rm = TRUE),
            ThaiPop = sum(thaiPop, na.rm = TRUE),
            VietPop = sum(vietPop, na.rm = TRUE),
            TwomPop = sum(twomPop, na.rm = TRUE),
            WasiPop = sum(wasiPop, na.rm = TRUE)
            ) %>%
  mutate(AsnPct = AsnPop / TotPop * 100) %>%
  mutate(IndiPct = IndiPop / TotPop * 100) %>% 
  mutate(BangPct = BangPop / TotPop * 100) %>% 
  mutate(BhutPct = BhutPop / TotPop * 100) %>% 
  mutate(BurmPct = BurmPop / TotPop * 100) %>% 
  mutate(CambPct = CambPop / TotPop * 100) %>% 
  mutate(ChinPct = ChinPop / TotPop * 100) %>% 
  mutate(FiliPct = FiliPop / TotPop * 100) %>% 
  mutate(HmonPct = HmonPop / TotPop * 100) %>% 
  mutate(IndoPct = IndoPop / TotPop * 100) %>% 
  mutate(JapaPct = JapaPop / TotPop * 100) %>% 
  mutate(KorePct = KorePop / TotPop * 100) %>% 
  mutate(LaotPct = LaotPop / TotPop * 100) %>% 
  mutate(MalaPct = MalaPop / TotPop * 100) %>% 
  mutate(MongPct = MongPop / TotPop * 100) %>% 
  mutate(NepaPct = NepaPop / TotPop * 100) %>% 
  mutate(OkinPct = OkinPop / TotPop * 100) %>% 
  mutate(PakiPct = PakiPop / TotPop * 100) %>% 
  mutate(SrilPct = SrilPop / TotPop * 100) %>% 
  mutate(TaiwPct = TaiwPop / TotPop * 100) %>% 
  mutate(ThaiPct = ThaiPop / TotPop * 100) %>% 
  mutate(VietPct = VietPop / TotPop * 100) %>% 
  mutate(TwomPct = TwomPop / TotPop * 100) %>% 
  mutate(WasiPct = WasiPop / TotPop * 100) %>%
  arrange(desc(AsnPct)) %>%
  select(code2013, AsnPct:WasiPct)

cty_ethn_agg$code2013 <- c("Large Central Metro", "Large Fringe Metro", "Medium Metro", "Small Metro", "Micropolitan", "Non-Core", "NA")
View(cty_ethn_agg)
write_csv(cty_ethn_agg, "~/GEOG 28602/Final Project/cty_ethn_agg2.csv")

# mapping the classifications
tm_shape(usa) + tm_borders(col = "black", alpha = 0) +
  tm_shape(urCodesGeom) + 
  tm_fill(col = "code2013", palette = "RdBu", n = 6, breaks = c(1, 2, 3, 4, 5, 6, 7), labels = c("Large Central Metro", "Large Fringe Metro", "Medium Metro", "Small Metro", "Micropolitan", "Non-Core")) + 
  tm_legend(title = " ", legend.position = c("left", "center"))
