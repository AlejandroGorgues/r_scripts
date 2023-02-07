library("ggplot2")
library("R.matlab")
library("scatterplot3d")
library("R.matlab")
library("rgl")
library("rglwidget")
library("reshape2")
library("gridExtra")
library("egg")
library("RColorBrewer")
#library("plot3D")
theme_set(theme_bw())


train_data <- readMat("")
test_data <- readMat("")
val_data <- readMat("")

train_df <- data.frame(train_data[[1]])
test_df <- data.frame(test_data[[1]])
val_df <- data.frame(val_data[[1]])

colnames(train_df) <- c("Mach", "AoA", "Delta_Sweep")
colnames(test_df) <- c("Mach", "AoA", "Delta_Sweep")
colnames(val_df) <- c("Mach", "AoA", "Delta_Sweep")

meshgrid_data <- readMat("")

RV <- meshgrid_data[[3]]

min_plot1<- 2
max_plot1<- dim(RV)[1]
step_plot1<- 1

min_plot2<-1
max_plot2<- tail((array(meshgrid_data[[2]])), 2)[1]

N <- data.frame(n_value = array(meshgrid_data[[2]]), RV_value=t(RV[seq(min_plot1, max_plot1, by=step_plot1),]))
K <- data.frame(k_value = array(meshgrid_data[[1]]), RV_value=RV[,min_plot2:max_plot2])

N_melted = melt(N, id.vars = 'n_value')
K_melted = melt(K, id.vars = 'k_value')

mesh_isomap<- mesh(array(meshgrid_data[[1]]), array(meshgrid_data[[2]]))

open3d()
plot3d(mesh_isomap[[1]], mesh_isomap[[2]], (meshgrid_data[[3]]))
rglwidget(elementId = "plot3drgl")


p1 <- ggplot()+geom_line(data=N_melted, aes(n_value, value, color=variable))
p2 <- ggplot()+geom_line(data=K_melted, aes(k_value, value, color=variable))

grid.arrange(p1, p2, ncol = 1)

custom_palette <- colorRampPalette(brewer.pal(length(unique(isomap_data$X.train[,2])), "RdBu"))(length(isomap_data$X.train[,2]))

isomap_data <- readMat("")

layout(matrix(c(1,2), nrow=1, ncol=2,byrow=TRUE))
scatterplot3d(x=isomap_data$y.iso.train[,1],y=isomap_data$y.iso.train[,2],z=isomap_data$y.iso.train[,3], 
              mar=c(5,3,3,7),
              angle=260,
              pch=20,
              color = custom_palette[cut(isomap_data$X.train[,2],length(isomap_data$X.train[,2]))],
              cex.symbols = isomap_data$X.train[,1])
image.plot(legend.only=TRUE, zlim= as.matrix(1:length(isomap_data$X.train[,2])), col=c(rev(custom_palette)))
library("fields")





