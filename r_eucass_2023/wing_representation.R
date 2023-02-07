library("scatterplot3d")
library("R.matlab")
library("rgl")
library("rglwidget")
source('http://www.sthda.com/sthda/RDoc/functions/addgrids3d.r')
data <- readMat("")
matrix_data <- array(matrix(data['X'][[1]]), c(6519, 3, 60))

size_points = data[[2]][,]
color_points = data[[3]][,]+1
x <- matrix_data[,1,1]
y <- matrix_data[,2,1]
z <- matrix_data[,3,1]

open3d()
plot3d(x,y,z, type="p", lit=TRUE, size=5, col=color_points, aspect=TRUE, main="Title")
