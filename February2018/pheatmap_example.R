# This is an example to demonstrate pheatmap package

# install.packages('pheatmap') # This is run the first time to install the package
library(pheatmap) # This loads the package

mydata <- iris # Using the famous iris dataset - comes with R

myannotation <- iris[, "Species", drop=F] # We want to label the map with the Species label
# drop=F is a fun tip. 
# By default, R will turn a data.frame into a vector when you select one column
# If you specify drop=FALSE (or drop=F to be brief), you keep a 1 column data.frame

mydata <- as.data.frame(t(mydata[,1:4])) # Select the numeric data (no Species label) and transpose

rownames(myannotation) <- paste("flower", 1:150, sep="") # pheatmap wants the rows and cols to match
colnames(mydata) <- paste("flower", 1:150, sep="")

pheatmap(mydata,
         annotation_col = myannotation,
         show_colnames = FALSE) # used myannotation to label cols, so don't also want labels

# Often, want to scale the rows - see relative level of each variable across all flowers
# Here - values for petal.width are all much lower than those for sepal.length
pheatmap(mydata,
         scale = "row",
         annotation_col = myannotation,
         show_colnames = FALSE) 

# Also may want to change how flowers are clustered
pheatmap(mydata,
         scale = "row",
         clustering_method = "ward.D2",
         clustering_distance_cols = "euclidean",
         annotation_col = myannotation,
         show_colnames = FALSE) 
