# This is the example analysis in a .R script
# There is also a .Rmd version for people who like Rmarkdown
# Load packages
library(ggplot2)

# Load some data about lead testing in children by zip code
# https://www.opendataphilly.org/dataset/philadelphia-child-blood-lead-levels
web_data <- read.csv("https://phl.carto.com/api/v2/sql?q=SELECT+*+FROM+child_blood_lead_levels_by_zip&filename=child_blood_lead_levels_by_zip&format=csv&skipfields=cartodb_id,the_geom,the_geom_webmercator")
View(web_data)

# Zillow makes home prices and other data available on their website:
# https://www.zillow.com/research/data/
# http://files.zillowstatic.com/research/public/Zip/Zip_MedianListingPrice_AllHomes.csv
zillow_data <- read.csv("http://files.zillowstatic.com/research/public/Zip/Zip_MedianListingPrice_AllHomes.csv")

# The data could be cleaned-up - columns appear to be values for a given year/month

# Lets merge to look at data
lead_dataset <- merge(web_data, zillow_data, by.x = "zip_code", by.y = "RegionName")

ggplot(lead_dataset, aes(x = X2017.11, y = perc_5plus)) +
  geom_point() +
  ylab("Percent of children screened with BLLs ≥5 µg/dL") + 
  xlab("Median home price, November 2017") +
  theme_bw()

ggplot(lead_dataset, aes(x = X2017.11, y = num_screen)) +
  geom_point() +
  ylab("Number of children screened") + 
  xlab("Median home price, November 2017") +
  theme_bw()
  
# The plots above are fairly boring. We could add some categories to facet by or color by.  
# For example:  
#   
# + Binning home prices to create categories
# + Adding in meta-data from other sources, such as the total population of each zip code 
# + Adding any factors that might differentiate zip codes with similar lead levels
# + Performing statistical tests

# Contact: philly@rladies.org
