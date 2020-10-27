
library(dplyr)

exponent <- function(x){
  if(x == "B") 1e9
  else if(x == "M") 1e6
  else if(x == "K") 1e3
  else 1
}

if(!file.exists("StormData.csv.bz2")){
  download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", 
                destfile = "StormData.csv.bz2")
}

CSV_raw <- read.csv2("StormData.csv.bz2", sep=",")

CSV <- CSV_raw %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)

CSV1 <- 
  CSV_raw %>% mutate(PROPDMGEXP = tolower(PROPDMGEXP), CROPDMGEXP = tolower(CROPDMGEXP)) %>% 
  filter(!is.na(match(PROPDMGEXP, c("", "k", "m", "b")))) %>% 
  filter(!is.na(match(CROPDMGEXP, c("", "k", "m", "b"))))


CSV$begin_date <- as.Date(CSV$BGN_DATE, "%m/%d/%Y"
CSV$event <- as.factor(tolower(CSV$EVTYPE))
CSV$PROPDMGEXP <- sapply(CSV$PROPDMGEXP, exponent)
CSV$CROPDMGEXP <- sapply(CSV$PROPDMGEXP, exponent)


View(CSV)
#View(titles)

