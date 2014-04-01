\name{classifyEEG}
\alias{classifyEEG}
\title{
Classifies new data
}
\description{
Classifies a new sample of EEG data based on an object produced by \code{\link{svmEEG}}.
}
\usage{
classifyEEG(y, data)
}
\arguments{
  \item{y}{
an object produced by \code{\link{svmEEG}}.
}
  \item{data}{
a new data set. Each column represents each channel, and each row represents the signals collected by these channels at the same time. Note that only one recording shall be given, in other words, the number of lines must be equal to the length of each recording in the training phase.
}
}
\value{
\item{pred}{
a vector with the predicted class and an associated probability.
}
}
\references{
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\seealso{
\code{\link{svmEEG}}, \code{\link{FeatureEEG}}
}
\examples{
library(eegAnalysis)

###Simulating the data set.
Sim <- randEEG(n.class=2,n.rec=10,n.signals=50,n.channels = 2, 
vars = c(2,1)) 

### Uncomment the next line to choose your own features
# features<-easyFeatures()



### Selecting the features
### The selected features may differ because the algorithm
### uses some random functions
### Obs: features="example" is used to be fast. Use features="default"
### or choose your own set of features.
x<-FeatureEEG(Sim$data,Sim$classes.Id,Sim$rec.Id,features="example",
               Alpha=0.05, AlphaCorr=0.9,minacc=0.8,fast=FALSE)




### Calculating the classifier
y<-svmEEG(x)
y$model 


### Generating new data to test the classifier
new <- randEEG(n.class=2,n.rec=30,n.signals=50,n.channels = 2, 
                      vars = c(2,1)) 


### Classifying the new data and counting the number of successes
cont = 0
for(i in 1:30)
{
  data<-new$data[which((new$classes.Id==1)&(new$rec.Id==i)),]
  if(classifyEEG(y,data)[2]==1)  cont = cont + 1
}

for(i in 1:30)
{
  data<-new$data[which((new$classes.Id==2)&(new$rec.Id==i)),]
  if(classifyEEG(y,data)[2]==2)  cont = cont + 1
}

### The correct classification rate:
cont/60

}
\keyword{ EEG}
\keyword{ classification}
\keyword{ features}
\keyword{ SVM}
\keyword{ signals}
