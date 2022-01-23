# Converting data from long to wide and back

# Create test wide dataframe
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)

# tidyr way
library(dplyr)
library(tidyr)
stocks_long <- gather(stocks, stock, price, -time)

stocks_long

# with reshape2
library(reshape2)
stocks_long <- melt(stocks, id.vars = "time", measure.vars = c("X","Y","Z"),
                    value.name = "price", variable.name = "stock")

# with base R - not quite right?
stocks_long <- reshape(stocks, direction = "long", 
                       idvar = "time", ids = c("X","Y","Z"), 
                       v.names = "price", varying = c("X","Y","Z"))


# Retrieve original data with complementary functions
# tidyr way - spread
stocks_wide <- spread(stocks_long, stock, price)


# reshape2
stocks_wide <- dcast(stocks_long, time ~ stock, value.var = "price")

# base R
stocks_wide <- reshape(stocks_long, direction = "wide",
                       idvar = "time", timevar = c("stock") )


