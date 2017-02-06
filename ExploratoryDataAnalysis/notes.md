# Exploratory Data Analysis


## ggplot2
learn to use this, put notes here.

-Aesthtics (aes(...)) - the data that you want displayed
-Geom (geometrics) - what you want displayed (e.g. points, fit lines, filled regions, etc.)
-Facet - different aspects of the data, this is like lattice plot stuff, by selecting one or more variables to facet on, multiple plots will be made, one for each category of the facets.


## clustering grouping observations together
### Hierarchal
requires a distance metric. look at all observations, pick the two that are closest, and form a cluster. Repeat. When considering distance from a cluster, there are two main options: 
- Average Linkage - the distance between a point and a cluster is the distance between the point and the mean position of all clustered points.
- Complete Linkage - the distance between a point and a cluster is the largest possible distance that can be measured between the point and any point in the cluster.

Hierarchal clustering is a bit like kt/anti-kt jet finding methods. Things close together are grouped first, and as the cluster grows things further away are added. The clustering generally continues until all points merge to form one single cluster, which isn't super useful. A Dendrogram is a tree like plot with distance on the y-axis and observations on the x-axis. It shows how observations are grouped together (i.e. clusters are formed) as the closest distance between things increases. The number of clusters in the data depends on where you "cut" the dendrogram - sometimes this is obvious, others not. You can get an idea from the dendrogram. Long vertical sections correspond to large increases in the minimum distance with no change in the clustering status, which suggests that the clusters at that time are somewhat distinct.

Hierarchal clustering is deterministic. The same clusters (dendrogram) will always be found (formed) for a given set of input data and distance metric/linkage model.

### K-means
Kind of like a cone based jet finding algorithm.

Need to supply a number of clusters to start with, and optionally some initial cluster positions. Each point is added to the cluster it is closest to. The cluster center is then recomputed, and the points are re-clustered. This continues untill either a maximum number of iterations is reached, or there are successive iterations in which no points change clusters. There is no fixed radius to the cones, each is as big as it needs to be to ensure that all points are clustered. 

This method is not deterministic. It depends on the initial starting points given for the clusters. The R function kmeans has an option to run the clustering multiple times, and select the trial that had the "best" results (presumably smallest cluster radius)

## dimension reduction
These are kinda the same thing. The course was kinda light on theory, will add some more notes to this later.
### SVD

### PCA

 