library(ggplot2)
library(tidyverse)


  #building plots
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + geom_point(alpha = 0.1, colour= green)

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, colour = species_id)) +geom_point(alpha=0.1)

#
#Challenge 3
#Use what you just learned to create a scatter plot of weight over species_id with the plot type showing in different colours. Is this a good way to show this type of data?
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight, colour = species_id)) + geom_point(alpha = 0.1)


#Boxplots!

#1 discrete & 1 continuous

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + geom_boxplot(alpha = 0) + geom_jitter(alpha = 0.3, colour = "tomato")


#Challenge 4
#Notice how the boxplot layer is behind the jitter layer? What do you need to change in the code to put the boxplot in front of the points such that it’s not hidden?
  
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))  + geom_jitter(alpha = 0.3, colour = "tomato") + geom_boxplot(alpha = 0)

#Challenge 5
#Boxplots are useful summaries but hide the shape of the distribution. 
#For example, if there is a bimodal distribution, it would not be observed with a boxplot. 
#An alternative to the boxplot is the violin plot (sometimes known as a beanplot), where the shape (of the density of points) is drawn.
#Replace the box plot with a violin plot

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))  + geom_jitter(alpha = 0.3, colour = "tomato") + geom_violin(alpha = 0)


#Challenge 6
#So far, we’ve looked at the distribution of weight within species. Make a new plot to explore the distribution of hindfoot_length within each species.
#Add color to the data points on your boxplot according to the plot from which the sample was taken (plot_id).

#Hint: Check the class for plot_id. Consider changing the class of plot_id from integer to factor. How and why does this change how R makes the graph?

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length, colour = plot_id))  +  geom_boxplot(alpha = 0)

#Step 2: Find he class of plot_id

class(surveys_complete$plot_id)
surveys_complete$plot_id <- as.factor(surveys_complete$plot_id)

#Challenge 7
#In many types of data, it is important to consider the scale of the observations. 
#For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. 
#Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). 

#Make a scatter plot of species_id on the x-axis and weight on the y-axis with a log10 scale.

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + geom_point() + scale_y_log10()

#Challenge 8
#Modify the code for the yearly counts to colour by genus so we can clearly see the counts by genus. 

#Challenge 9
#How would you modify this code so the faceting is organised into only columns instead of only rows?
  
#Challenge 10
#Put together what you’ve learned to create a plot that depicts how the average weight of each species changes through the years.

#Hint: need to do a group_by() and summarize() to get the data before plotting






