
################
##plot: start with the basics
library(ggplot2)
library(dslabs)
library(tidyverse)
data(heights)
data(murders)

###just add the points
p <- ggplot(data = murders)
p <- p + geom_point(aes(population/10^6, total))
p


###scale in log, geon point of same size and title
p <- ggplot(data=murders, aes(population/10^6, total, label = abb))
p <- p + geom_point(size = 3) +  
  geom_text(nudge_x = 0.05) + 
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") + 
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")
p

##############################################################
#######exercise:let's add another variable and colour by region
###############################################################
p <- ggplot(data=murders, aes(population/10^6, total, label = abb))
p <- p + geom_point(aes(col=region), size = 3)  +  
  geom_text(nudge_x = 0.05) + 
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") + 
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")
p



#####################################
#####distribution

# for numeric data: we can define a function that reports the proportion of the data below  
#a for all possible values of a. 
#This function is called the emipirical cumulative distribution function (eCDF), 
#it can be plotted, and it provides a full description of the distribution of our data




p<- ggplot(data=heights, aes(x=sex, y=height)) + 
  geom_bar(stat="identity")
p


p<- ggplot(data=heights, aes(x=sex, y=height, colour=sex)) + 
  geom_bar(stat="identity", fill='white')
p


p1<- ggplot(data=heights, aes(x=sex, y=height, colour=sex)) + 
  geom_bar(stat="identity")+theme_minimal()
p1 <- p1+ labs(x='', colour = "Ciao")
p1

p2<- ggplot(data=heights, aes(x=sex, y=height, colour=sex)) + 
  geom_bar(stat="identity")+theme_minimal()
p2 <- p2+ labs(x='', colour = "Gender")
p2


##divide in group: trasnform the name of Y with Capital letter



#Suppose we can't make a plot and want to compare the distributions side by side. We can't just list all the numbers. 
#Instead we will look at the percentiles. Create a five row table showing female_percentiles and male_percentiles with the 10th, 30th, 50th, ..., 90th percentiles for each sex. Then create a data frame with these two as columns.


library(dslabs)
data(heights)
male <- heights$height[heights$sex=="Male"]
male_percentiles <- quantile(male, seq(0.1, 0.9, 0.2))

#####Question 1
####divide in groups, can you do for female?
data.frame(female_percentiles, male_percentiles) 

#####Question 2
#####In which percentiles there is the maximum differences between the gender? 

####return to presentation

####Let's see the boxplot
p <- ggplot(heights, aes(x=sex, y=height)) + geom_boxplot()
p
# Rotate the box plot
p + coord_flip()
# Notched box plot
ggplot(heights, aes(x=sex, y=height)) + 
  geom_boxplot(notch=TRUE)

###Question 3
###divide in group, can you compute the median and see if it corresponds to the boxplots? What is the median in total? For the male? And for the female?


####return to presentation

head(heights)
ggplot(heights, aes(height)) + stat_ecdf(geom = "step")
ggplot(heights, aes(height)) + stat_ecdf(geom = "step")+
  labs(title="Empirical Cumulative \n Density Function",
       y = "F(height)", x="Height in inch")+
  theme_classic()


##Question 4
#Divide in group: Suppose all you know about the data is the average and the standard deviation. Use the normal approximation to estimate the proportion you just calculated.

data(heights)
x <- heights$height[heights$sex=="Male"]

avg <- mean(x)
stdev <- sd(x)
pnorm(71, avg, stdev) - pnorm(69, avg, stdev)

####qqplot
###is the distribution normal?
p <- seq(0.05, 0.95, 0.05)

sample_quantiles <- quantile(x, p, na.rm=TRUE)
theoretical_quantiles <- qnorm(p, mean = mean(x,na.rm=TRUE), sd = sd(x, na.rm=TRUE))
?qnorm
qplot(theoretical_quantiles, sample_quantiles) + geom_abline()


norm_theor <- rnorm(1000, 2, 2)
hist(norm_theor)



ggplot(heights, aes(x=height)) + geom_histogram(binwidth=1)

##Question 5
##In group: adjust the bin to have a nice histogram

###let's do the curve
ggplot(heights, aes(x=height)) + geom_density(alpha=.3)







