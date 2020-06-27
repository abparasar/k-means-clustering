#--------------------------importing data ----------------------------------

# setting the working directory where we have our data)
setwd('C:/Users/HP/Desktop/edu/PBA-Ins-Clustering/PBA-Ins-Clustering/data')

# reading the .csv file
railway_data <- read.csv('Rail_Data.csv')

summary(railway_data)
View(railway_data)


#------------------------- preparing data -------------------------

# scale data for mean = o and deviation = 1, dont include column 1 as it is train number
scaled.dat <- scale(railway_data[,-1])


View(scaled.dat)

#bind the scaled data with train number again
scaled.dat<- as.data.frame(cbind(Train.Number = railway_data[,1],scaled.dat))

View(scaled.dat)



#----------------Run the kmeans algo--------
set.seed(20)

# call kmeans function without column 1 as col 1 is train number with k(cluster) = 5
cluster_output <- kmeans(scaled.dat[,-1], 5)

str(cluster_output)
cluster_output$centers

#which observation belongs to which
clusters= cluster_output$cluster
cluster_output$centers
cluster_output$tot.withinss


#initialize
wss = c(1:15)


#Plotting kmeans variance (at least 1 clusters), and max 15 (random number)
for (i in 1:15) wss[i] <- sum(kmeans(scaled.dat[,-1],centers=i)$withinss)

wss

plot(1:15, wss, type='b', xlab='Number of Clusters', ylab='Within groups sum of squares',col='mediumseagreen')



final_data <- as.data.frame(cbind(scaled.dat,clusters))

# ------------ pattern------

library(ggplot2)
ggplot(final_data,aes(Average.Kms.Per.Day,Passenger.Kilometers,color=as.factor(clusters)))+geom_point()


