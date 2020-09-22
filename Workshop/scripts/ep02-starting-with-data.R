#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html



# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

# now we will read this "csv" into an R object called "surveys"
surveys <- read.csv("data_raw/portal_data_joined.csv")

# and take a look at it

surveys
head(surveys)
View(surveys)

# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may been to tell read.csv more about our file.



# So what kind of an R object is "surveys" ?

class(surveys)

# ok - so what are dataframes ?
str(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
head(surveys,2)
tail(surveys,2)
names(surveys)
summary(surveys)
mean(surveys$weight, na.rm=TRUE)

# --------
# Exercise
# --------
#
# What is the class of the object surveys?
#
# Answer: data frame


# How many rows and how many columns are in this survey ?
#
# Answer: 13

# What's the average weight of survey animals
#
#
# Answer: 42.67

# Are there more Birds than Rodents ?
#
#
# Answer: No


# 
# Topic: Sub-setting
#

# first element in the first column of the data frame (as a vector)
surveys[1,1]

# first element in the 6th column (as a vector)
surveys[1,6]

# first column of the data frame (as a vector)
surveys[, 6]

# first column of the data frame (as a data frame)
head(surveys[1])
# first row (as a data frame)
head(surveys[1, ])

# first three elements in the 7th column (as a vector)
surveys[1:3, 7]

# the 3rd row of the data frame (as a data.frame)
surveys[3, ]

# equivalent to head(metadata)

head(surveys)
surveys[1:6, ]
# looking at the 1:6 more closely
1:6

# we also use other objects to specify the range

rows <- 6
surveys[rows,1]

#
# Challenge: Using slicing, see if you can produce the same result as:
#
#   tail(surveys)
#
# i.e., print just last 6 rows of the surveys dataframe
#
# Solution:
end <- nrow(surveys)
surveys[34781:34786, ]
nrow(surveys)
surveys[(end-5):end, ]

# We can omit (leave out) columns using '-'
surveys[-1]            #get rid of column 1
surveys[c(-1, -3, -4)]   #get rid of columns 1, 3 and 4)
surveys[-(1:3)]           #remove a range

# column "names" can be used in place of the column numbers
surveys["month"]  #getting data fram from a column using the name instead of column number


#
# Topic: Factors (for categorical data)
#
gender <- c("male", "male", "female")
gender <- factor(c("male", "female", "female"))
class(gender)
levels(gender)
nlevels(gender)

# factors have an order
temperature <- factor(c("hot", "cold", "hot", "warm"))
temperature[1]                                                                                   #default level is alphabetical
temperature <- factor( c("hot", "cold","hot","warm"), level = c("cold", "warm", "hot"))          #but we can tell it how we should assign the levels
# Converting factors
as.numeric(temperature)
as.character(temperature)

# can be tricky if the levels are numbers
year <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year)                      #changes to numbers in order e.g., 1977 =1, 1983 = 2 etc.)
as.character(year)                    #changes to characters e.g. "1977", "1983" etc.
as.numeric(as.character(year))        #changes back to original numbers
as.array(year)
# so does our survey data have any factors
str(surveys)

#
# Topic:  Dealing with Dates
#


# R has a whole library for dealing with dates ...
library(lubridate)      #the "library fucntin" calls up a library 
# date:7-16-1977    #to make itdo this we need to paste together the month, day and year columns so it looks like the exmaple on the left

my_date <- ymd("2015-01-01")
class(my_date)


# R can concatenated things together using paste()

paste("abc", "123")                     #this makes "abc 123"
paste("abc", "123", sep = "-")           #this changes the space to a "-"
paste("2015", "01", "26", sep = "-")      #this combines a year, month and day to make a date format
ymd(paste("2015", "01", "26", sep = "-")) #now it recognises it as a date
my_date <- ymd(paste("2015", "01", "26", sep = "-"))  #now it is a factor
class(my_date)                                         #and if we check, then r recognises it as a date
# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns
surveys$year                                         #this refers to the column "year"
paste(surveys$year, surveys$month, surveys$day)      #now we know how to refer to the column, we can combine them
paste(surveys$year, surveys$month, surveys$day, sep = "-")  

ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))                    #use lubridate to make it realise this is a date

surveys$date <- ymd (paste(surveys$year, surveys$month, surveys$day, sep = "-"))    #make r create a column of the combined date
# let's save the dates in a new column of our dataframe surveys$date 


# and ask summary() to summarise 
summary(surveys)

# but what about the "Warning: 129 failed to parse"
#some data could not be converted to a date so data needs to be checked
#so, to check why this has happened, we might run a summary of that column

summary (surveys$date)
#this shows lots of "NAs", which would not have been converted. 
#now to find where the NAs are
is.na(surveys$date)   
#this gives us "TRUE" and "FALSE" for each entry, which is not practical for this amount of data. So try:
missing_date <- surveys[is.na(surveys$date), c("year", "month", "day")]
missing_date
#so we are able to see the data and realise that the days were "31" for months with only 30 days, so it could not be recognised as a date

