\name{featureSelection}
\alias{featureSelection}
\alias{print.featuresSelected}
\alias{summary.featuresSelected}
\title{
Feature Selection Algorithm
}
\description{
This algorithm allows the user to use his own features. Thus, the \code{featureSelection} function selects the best set of the features among the features given by the user. It can be used to select features of any number of classes.
}
\usage{
featureSelection(features, classes.Id, alpha = 0.05, alphaCorr = 0.05, 
minAcc = 0.7, fast = FALSE, testProp = 0.2)
}
\arguments{
  \item{features}{
is the data set containing the features. The data frame must be organized as follows: each row represents a different feature, and each columns represents each replication of that feature for each class in the study.
}
  \item{classes.Id}{
is a vector with length equal to the number of columns of \code{data}. Thus, each value in the vector identifies the class ID of each column. For example, let \code{classes.Id = c(rep(1,5),rep(2,5))}, this means that the first 5 columns of \code{data} represents the class with ID 1 and the columns 6 to 10 represent the class with ID 2.
}
  \item{alpha}{
a vector with the significance level for each FDR test to be performed. It has to be a number between 0 and 1. The closer to zero, the less features tend to be selected. See details.
}
  \item{alphaCorr}{
significance level for the correlation test. It has to be a number between 0 and 1. The closer to zero, the less features tend to be selected. See details.
}
  \item{minAcc}{
minimum accuracy to be achieved by the SVM test. It has to be a number between 0 and 1. The closer to one, the less features tend to be selected. See details.
}
  \item{fast}{
If \code{FALSE} it uses the SVM implementation of the \code{e1071} package. If \code{TRUE} the algorithm uses another implementation optimized for the one dimensional case that tends to be much faster, but it may not converge in some cases.
}
  \item{testProp}{
the proportion of replicates of each class used in the test phase of the SVM test. See details.
}
}
\details{
The feature selector is a statistical algorithm that performs several tests to select the best set of features to classify a new data set in the future. The feature selection is performed the following steps:

1- The training set is divided in two sets. The number of replicates (samples, recordings) of each class in each set is defined by the parameter \code{testProp}.

2- A analysis of variance is evaluated and a false discovery rate (FDR) test, with significance level given by the parameter \code{alpha}, is performed to select the features with the greatest differences between classes means.

3- For each feature selected, a SVM classifier is trained individually for the first group of replicates defined randomly by the parameter \code{testProp}. 

4- The features are extracted from the second group of replicates and classified. The features with a correct classification rate of at least \code{minAcc} (parameter) are selected.

5- A correlation test is performed to eliminate redundant features with significance level given by \code{alphaCorr}.
}
\value{
\item{Selected}{
A vector with the number of the features selected. In other words, each number in this vector represents the number of the row selected from the original data set.
}
\item{FDRscore}{
A vector that represents the score of each selected feature in the FDR test. It is a value between 0 and 1. The closer to 1, the better is the selected feature in terms of this test.
}
\item{SVMscore}{
A vector that represents the score of each selected feature in the SVM test. It is a value between 0 and 1. The closer to 1, the better is the selected feature in terms of this test.
}
}
\references{
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.

Coutinho, M. (2013) \emph{Selecting features for EEG classification and constructions of Brain-Machine Interfaces.} Universidade de Brasilia (UnB), Master dissertation.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\examples{
library(eegAnalysis)

### Simulating some features

# number of features
n.features = 150
# number of replications of class A
n.classA = 200
# number of replications of class B
n.classB = 250

# initializing the features data frame
features<-mat.or.vec(n.features,n.classA+n.classB)
# initializing the classes.ID vector
classes.Id<-c(rep(0,n.classA),rep(1,n.classB))


# simulating the features with the normal distribution
# note that the higher the number of the row, the higher 
# is the gap between the means of the simulated normal distribution
for(i in 1:n.features)
{
  features[i,]<-c(rnorm(n.classA,1,1),rnorm(n.classB,1+i/200,1))
}

### Selecting the features and comparing the speed changing the fast parameter
### NOTE: there may be differences between the selected features due to some 
### randomness present in the algorithm.
system.time({
  feat<-featureSelection(features, classes.Id, alpha = 0.05, alphaCorr = 0.05, 
                         minAcc = 0.65, fast = FALSE, testProp = 0.2)
})
system.time({
  fastFeat<-featureSelection(features, classes.Id, alpha = 0.05, alphaCorr = 0.05, 
                             minAcc = 0.65, fast = TRUE, testProp = 0.2)
})


### Reducing the initial data frame to the selected features
names(fastFeat)
SelectedFeatures <- features[fastFeat$Selected,]

}
\keyword{ EEG}
\keyword{ classification}
\keyword{ features}
\keyword{ SVM}
\keyword{ signals}
