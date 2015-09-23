library(reshape)

# READ IN CSV FILES
setwd("C:\\Path\\To\\Data\\Files")

Doodles2010 <- read.csv("GoogleDoodles2010.csv")
Doodles2011 <- read.csv("GoogleDoodles2011.csv")
Doodles2012 <- read.csv("GoogleDoodles2012.csv")
Doodles2013 <- read.csv("GoogleDoodles2013.csv")
Doodles2014 <- read.csv("GoogleDoodles2014.csv")
Doodles2015 <- read.csv("GoogleDoodles2015.csv")

DoodlesAll <- rbind(Doodles2010, Doodles2011, Doodles2012, 
                    Doodles2013, Doodles2014, Doodles2015)

# MODIFY DATE FIELDS
DoodlesAll$DoodleDate <- as.Date(DoodlesAll$DoodleDate, '%m/%d/%Y')
DoodlesAll$Year <- format(DoodlesAll$DoodleDate, '%Y')
DoodlesAll$Month <- format(DoodlesAll$DoodleDate, '%m')
DoodlesAll$Day <- format(DoodlesAll$DoodleDate, '%d')
str(DoodlesAll)

DoodlesAll <- DoodlesAll[order(DoodlesAll$DoodleDate),]
DoodlesAll$DoodleDate <- NULL

# RESHAPE DATA FRAME
DoodlesTransposed <- reshape(DoodlesAll, timevar = "Month",
                    idvar = c("Year", "Day"), direction = "wide")

# CLEAN UP OUTPUT DATA FRAME
DoodlesTransposed <- DoodlesTransposed[order(DoodlesTransposed$Year, 
                                             DoodlesTransposed$Day),]

names(DoodlesTransposed) <- c('Year', 'Day', 'January', 'February', 'March', 
                              'April', 'May', 'June', 'July','August',
                              'September', 'October', 'November', 'December')

DoodlesTransposed[, (3:14)] <- sapply(DoodlesTransposed[,(3:14)],as.character)
DoodlesTransposed[is.na(DoodlesTransposed)] <- ""

# SAVE DATA FRAME TO CSV FILE
setwd("C:\\Path\\To\\Work\Directory")
write.csv(DoodlesTransposed, 'DoodlesTransposedR.csv', row.names=FALSE)

