# load the function that makes the sat plots
source('moving_sats.R')


#### Files organization ####
# This is meant to be used with the NMEA extractor tool: https://serialc.github.io/gnss_accuracy_and_error_oer/processing/
# That should create the folders and data in a structure manner that is an input for these scripts


#### The easiest option ####
# Make a plot of the satellite paths
plotFileSats('belval.csv')
# it is saved as images/belval_satpaths.png

# You can plot just one type of GNSS, such as GLN (GLONASS) or GPS
plotFileSats('belval.csv', one_gnss="GPS")

# there is no GLN data here so it will not work
plotFileSats('belval.csv', one_gnss="GLN")

# you can invert east-west if you prefer
plotFileSats('belval.csv', invert=TRUE)


#### Composing a satellite plot with added options ####
# load data from the as, ll, and as data folders
raw_data <- loadSatData('belval.csv')
# remove any rows that are empty or incomplete
data <- raw_data[!is.na(raw_data$satnum),]

# define a colour for all sats
data$col <- assignColourToSats(data$satnum)

# select which points from the data you would like to plot
sdata <- data[data$llid == 39,]

# basic plot
plotSats(sdata)
# plot without black circles
plotSats(sdata, sat.bg = FALSE)
# inverting the east-west
plotSats(sdata, invert=TRUE)
# plot without the large background circles
plotSats(sdata, invert=TRUE, bg=FALSE)
# add just the background and then the foreground separately
# allows adding other things in between
plotSats(sdata, invert=FALSE, bg=TRUE, fg=FALSE)
plotSats(sdata, invert=FALSE, bg=FALSE, add=TRUE)
# add other points to the map but with low opacity
plotSats(sdata, invert=TRUE, bg=TRUE, fg=FALSE)
plotSats(data, invert=TRUE, bg=FALSE, fg=TRUE, sat.bg=FALSE, opacity=0.1, add=TRUE)
plotSats(sdata, invert=TRUE, bg=FALSE, add=TRUE)


#### Making an animation ####
animateSats('belval.csv')
