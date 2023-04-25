library(tidyverse)

# read in the data 
wins <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/winners.csv')
ldn_mthn <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/london_marathon.csv')

# look at data in different ways 
View(wins)
View(ldn_mthn)

glimpse(wins)
glimpse(ldn_mthn)

library(skimr)

skim(wins)
skim(ldn_mthn)

#--- Plot Time by Year ----
ggplot(wins, aes(x = Year, y = Time)) + 
  geom_point() + 
  facet_wrap(~Category)

#--- Create a wheelchair variable ----
wins %>% 
  mutate(wchair = str_detect(Category, "chair")) -> wins

# idea: ggflag? nationality 
# https://github.com/jimjam-slam/ggflags

ggplot(wins, aes(x = Year, y = Time)) + 
  geom_point() + 
  facet_wrap(~Category, scales = "free_y") 

# install ggflags 

remotes::install_github("jimjam-slam/ggflags")

library(ggflags)

men <- filter(wins, Category == "Men")
women <- filter(wins, Category == "Women")
wmen <- filter(wins, Category == "Wheelchair Men")
wwomen <- filter(wins, Category == "Wheelchair Women")

ggplot(data = men, aes(x = Year, y = Time, color = Nationality)) + 
  geom_point()

# convert nationality to 2-letter country codes 
# install.packages("countrycode")
library(countrycode)

str_to_lower(
  countrycode(
    men$Nationality, "country.name", destination = "genc2c"
    )
)

countries <- tibble(Nationality = unique(wins$Nationality)) %>% 
  mutate(ccode = str_to_lower(countrycode(Nationality, "country.name", "genc2c")))

countries  

men %>% 
  left_join(countries) %>% 
  ggplot(aes(x=Year, y=Time, country=ccode)) + 
  geom_flag() + 
  scale_country() 
  
wins %>% 
  left_join(countries) %>% 
  ggplot(aes(x = Year, y = Time, country = ccode)) + 
  geom_flag(position = "jitter") + 
  scale_country() + 
  facet_wrap(~Category, scales = "free_y") 

library(patchwork)

nats <- countries$Nationality
names(nats <- countries$ccode)


men %>% 
  left_join(countries) %>% 
  ggplot(aes(x = Year, y = Time, country = ccode)) + 
  geom_flag() + 
  scale_country() + 
  labs(country = "Nationality")

make_plot <- function(dat){
  dat %>% 
    left_join(countries) %>% 
    ggplot(aes(x = Year, y = Time, country = ccode)) + 
    geom_flag() + 
    scale_country() + 
    scale_y_time(labels = ~make_pretty_time(.x)) + 
    labs(country = "Nationality") + 
    theme_classic() 
}


p1 <- make_plot(men) + ggtitle("Men")  
p2 <- make_plot(women)+ ggtitle("Women")
p3 <- make_plot(wmen)+ ggtitle("Wheelchair Men")
p4 <- make_plot(wwomen)+ ggtitle("Wheelchair Women")

(p1 + p2) / (p3 + p4) 

library(lubridate)

make_pretty_time <- function(x){
  paste(hour(x), 
         str_pad(minute(x), 2, 'left', "0"), 
         str_pad(round(second(x)), 2, 'left', "0"), 
         sep = ":")
}

p3 +  
  scale_y_time(
    labels = ~make_pretty_time(.x)
  )

scale_y_time(labels = ~make_pretty_time(.x))

p1 <- make_plot(men) + ggtitle("Men")  
p2 <- make_plot(women)+ ggtitle("Women")
p3 <- make_plot(wmen)+ ggtitle("Wheelchair Men")
p4 <- make_plot(wwomen)+ ggtitle("Wheelchair Women")

(p1 + p2) / (p3 + p4) 
