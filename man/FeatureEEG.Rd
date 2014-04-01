\name{FeatureEEG}
\alias{FeatureEEG}
\alias{print.featureEEG}
\alias{summary.featureEEG}
\title{
Automatic Feature Selection
}
\description{
Select the best features to classify EEG data. This function receives as input a list of features defined by the user using the \code{\link{easyFeatures}} function. Then, the algorithm will use several statistical tests to search for the the best set of features in terms of classification. This kind of analysis is very useful to reduce the dimensionality of the data, producing much faster and accurate classifiers.
}
\usage{
FeatureEEG(data, classes.Id, rec.Id, nselec = "default", features = "default", 
Alpha = 0.05, AlphaCorr = 0.05, minacc = 0.7, Nfea = 10, fast = FALSE)
}
\arguments{
  \item{data}{
is the data frame containing the EEG signals. The data frame must be organized as follows: each column represents a different channel. Thus, the signals collected by each channel are represented in each row. To identify the class and recording represented by each line, the vectors \code{classes.Id} and \code{rec.Id} should be given and must have length equal to the number of rows in the data frame.
}
  \item{classes.Id}{
is a vector with length equal to the number of rows in \code{data}. Thus each value in the array identifies the class ID of each signal in each row of the database. For example, let \code{classes.Id = c(rep(1,5),rep(2,5))}, this means that the first 5 rows of \code{data} represents the class with ID 1 and the lines 6 to 10 represent the class with ID 2. NOTE: Only two classes are allowed.
}
  \item{rec.Id}{
is a vector with length equal to the number of rows in \code{data}. Thus each value in the array identifies the recording ID of each signal in each row of the database. For example, let \code{rec.Id <- c(rep(1,5),rep(2,5))}, this means that the first 5 rows of \code{data} represents the recording with ID 1 of some class and the lines 6 to 10 represent the recording with ID 2 of some class. \code{rec.Id} must be numeric and numerated from 1 to the total number of recordings for each class.
}
  \item{nselec}{
is a vector of size 2, representing the number of recordings to be randomly chosen within each class to be used as training set of the SVM test in the feature selection algorithm.
}
  \item{features}{
is a list containing all the types of features to be used. It is easier to produce this list using the \code{\link{easyFeatures}} function. If \code{features=}\code{"default"} uses a default set of features.
}
  \item{Alpha}{
a vector with the significance level for each FDR test to be performed. It has to be a number between 0 and 1. The closer to zero, the less features tend to be selected. See details.
}
  \item{AlphaCorr}{
significance level for the correlation test. It has to be a number between 0 and 1. The closer to zero, the less features tend to be selected. See details.
}
  \item{minacc}{
minimum accuracy to be achieved by the SVM test. It has to be a number between 0 and 1. The closer to one, the less features tend to be selected. See details.
}
  \item{Nfea}{
the maximum number of types of features selected by the feature selector algorithm.
}
  \item{fast}{
If \code{FALSE} it uses the SVM implementation of the \code{e1071} package. If \code{TRUE} the algorithm uses another implementation optimized for the one dimensional case, usually much faster but with no guarantee of convergence.
}
}
\details{
The feature selector is a statistical algorithm that performs several tests to select the best set of features to classify a new data set in the future. The feature selection is performed following the steps:

1- The training set is divided in two sets. The number of recordings of each class in each set is defined by the parameter \code{nselec}.

2- An analysis of variance is evaluated and a false discovery rate (FDR) test, with significance level given by the parameter \code{Alpha}, is performed to select the features with the greatest differences between classe. The mean is used to represent each class.

3- For each feature selected, a SVM classifier is trained individually for the first group of recordings defined by the parameter \code{nselec}. 

4- The features are extracted from the second group of recordings and classified. The features with a correct classification rate of at least \code{minacc} (parameter) are selected.

5- A correlation test is performed to eliminate redundant features with significance level given by \code{AlphaCorr}.
}
\value{
\item{output}{
This function outputs a list that can be used with the function \code{\link{svmEEG}} to produce a classifier.
}
}
\references{
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.

Coutinho, M. (2013) \emph{Selecting features for EEG classification and constructions of Brain-Machine Interfaces.} Universidade de Brasilia (UnB), Master dissertation.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\seealso{
\code{\link{svmEEG}}, \code{\link{easyFeatures}}
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
### Obs: features="example" is used just to be a fast example. 
### Use features="default" or choose your own set of features.
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
