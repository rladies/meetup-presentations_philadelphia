#Data Cleaning with R
#R-Ladies Philly
#June 21, 2018

#load required packages####
if(!require("dplyr")) install.packages("dplyr") ; library(dplyr)
if(!require("stringr")) install.packages("stringr") ; library(stringr)
if(!require("reshape")) install.packages("reshape") ; library(reshape)
if(!require("tidyr")) install.packages("tidyr") ; library(dplyr)

#import dataset####
#dataset taken from https://www.opendataphilly.org/dataset/farmers-markets-locations/resource/d23195c1-b7ce-4ae0-a81c-51753d096c6f
#may need to give path if .csv is not in current working directory
markets <- read.csv("Philadelphia_Farmers_Markets.csv")
class(markets) #imported as data frame; we can also import data as matrix - how is this different?

#inspect your data####
head(markets) #first six rows of dataset
names(markets) #variable names
dim(markets) #dimensions of data frame
summary(markets) #how many NAs do we have per variable
View(markets) #data-viewer
str(markets) #display internal structure

#dealing with missing values####
#replace blanks/spaces with NAs
markets[markets==""| markets==" "] = NA
#this command only works for character variables, not factor variables. why?

#for factor variables:
markets <- markets %>%
  mutate_if(is.factor, funs(factor(replace(., .=="" | .==" ", NA))))

#RSVP Question: What do you do when there are text NAs where actual NAs should be?
markets[markets=="NA"]<-NA

#we can solve all of the problems above by changing the arguments when importing data:
markets <- read.csv("Philadelphia_Farmers_Markets.csv", na.strings=c("NA","NaN", " ", ""))
str(markets)

#variable types####
#find out what class each variable in the dataset is
str(markets)
#could also use lapply(markets, class)

#why don't we have any character variables?
#default setting for read.csv is to import strings as factors
#to change this, and reimport the dataset with strings as characters we could run:
markets <- read.csv("Philadelphia_Farmers_Markets.csv", stringsAsFactors = F, na.strings=c("NA","NaN", " ", ""))
str(markets) #now all variables containing strings are of class 'character'

#change class of variable####
#what if we want to consider a character variable as a factor?
#in this dataset, "NEIGHBORHOOD" is the most likely factor variable since it has discernable levels
markets$NEIGHBORHOOD <- as.factor(markets$NEIGHBORHOOD)
class(markets$NEIGHBORHOOD) # now it is a factor
levels(markets$NEIGHBORHOOD)# factor variables have levels. notice that some of these levels are redundant

#dealing with inconsistent values, e.g. in free text fields (RSVP Question)####
#white space in variable values
#https://bookdown.org/lyzhang10/lzhang_r_tips_book/how-to-deal-with-empty-spaces.html
help(str_trim)
markets <- markets %>% #note this saves the changes to the dataframe
  mutate(NEIGHBORHOOD = str_trim(NEIGHBORHOOD))

unique(markets$NEIGHBORHOOD)

#capitalization in variable values using grep (RSVP question)
index <- grepl("city", markets$NEIGHBORHOOD, ignore.case = TRUE) #CITY cITY cItY
markets$NEIGHBORHOOD[index] = "Center City"
unique(markets$NEIGHBORHOOD)

#let's check our work
unique(markets$NEIGHBORHOOD)
levels(markets$NEIGHBORHOOD)
class(markets$NEIGHBORHOOD) #why is this back to being a character? str_trim and grepl operate on character vectors so they likely coerce NEIGHBORHOOD to character
markets$NEIGHBORHOOD <- as.factor(markets$NEIGHBORHOOD) #now we are back to meaningful levels

#reshaping / pivoting data####
#right now our data is in 'long' format, if we wanted to organize by NEIGHBORHOOD and put the data in 'wide' format, we could use reshape() in Base R:
markets_wide <- reshape(markets, idvar = "NEIGHBORHOOD", timevar = "OBJECTID", direction = "wide")
View(markets_wide)
#to pivot data, we can use the reshape package and the melt and cast functions

#saving out your cleaned dataset####
#this is useful so you don't need to repeat each of these steps for future analysis!
#save the script you clean your data in, and save a copy of the raw data for reference
write.csv(markets, "cleaned_Philadelphia_Farmers_Markets.csv")

