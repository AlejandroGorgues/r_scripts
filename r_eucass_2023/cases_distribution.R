library("ggplot2")
library("R.matlab")
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

train_df$Split <- c("Train")
test_df$Split <- c("Validation/Test")
val_df$Split <- c("Validation/Test")

dataset_df <- rbind(train_df, test_df, val_df)

gplot() + geom_point(data=dataset_df, aes(x = Mach, y= AoA, color=Split)) + 
  scale_color_manual(values = c("Train"="blue", "Validation/Test" = "red")) + 
  theme(legend.background = element_rect(color ="black",linetype ="solid")) +
  facet_grid(~ Split,labeller = labeller(Split = 
                                          c("Train" = "Train 70%",
                                            "Validation/Test" = "Validation & Test 30%")
  )) +
  scale_y_continuous(n.breaks = 10) +
  scale_x_continuous(n.breaks = 10)

