---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

```{r}
library(caret)

dataurl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/statlog/vehicle/xaa.dat"
download.file(url = dataurl, destfile = "wine.data")
vehicles_df <- read.csv("wine.data", header = FALSE, sep='')
str(vehicles_df)

set.seed(3033)
intrain <- createDataPartition(y = vehicles_df$V1, p=0.7, list= FALSE)
training <- vehicles_df[intrain,]
testing <- vehicles_df[-intrain,]
cat("Dimens�o do dataframe: ", dim(vehicles_df), "\n")
cat("Dimens�o do treinamento: ", dim(training), "\n")
cat("Dimens�o do teste: ", dim(testing), "\n")

summary(vehicles_df)

training[["V19"]] = factor(training[["V19"]])

trctrl <- trainControl(method = "boot")
set.seed(3333)
knn_fit <- train(V19 ~., data = training, method = "knn", trControl = trctrl, preProcess = c("center", "scale"), tuneLength = 10)
knn_fit

test_pred <- predict(knn_fit, newdata = testing)
test_pred

confusionMatrix(test_pred, testing$V19)

```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).
