\name{svmEEG}
\alias{svmEEG}
\alias{print.svmEEG}
\alias{summary.svmEEG}
\title{
Support Vector Machines
}
\description{
\code{svmEEG} is used to train a support vector machine classifier of the features selected by the function \code{\link{FeatureEEG}}. Internally, this function uses the \code{\link{svm}} function available in the \code{e1071} package. Thus, it is recommended to understand the \code{\link{svm}} function before using \code{svmEEG}.   
}
\usage{
svmEEG(x, method = "C-classification", scale = TRUE, kernel = "radial", 
degree = 3, gamma = if (is.vector(x)) 1 else 1/ncol(x), coef0 = 0, 
cost = 1, nu = 0.5, class.weights = NULL, cachesize = 40, tolerance = 0.001, 
epsilon = 0.1, shrinking = TRUE, cross = 0, probability = TRUE, 
fitted = TRUE, seed = 1L, subset, na.action = na.omit)
}
\arguments{
  \item{x}{
the features to be classified. Must be a list of class \code{featureEEG} produced by the function \code{\link{FeatureEEG}}.
}
  \item{method}{
the method to be used in \code{\link{svm}}. It has to be a classification machine.
}
  \item{scale}{
a logical vector indicating the variables to be scaled. If \code{scale} is of length 1, the value is recycled as many times as needed. Per default, data are scaled internally to zero mean and unit variance. The center and scale values are returned and used for later predictions. See \code{\link{svm}} for more details.
}
  \item{kernel}{
the kernel used in training and predicting. One of: \code{linear}, \code{polynomial}, \code{radial} \code{basis} or \code{sigmoid}. See \code{\link{svm}} for more details.
}
  \item{degree}{
parameter needed for kernel of type \code{polynomial}. See \code{\link{svm}} for more details.
}
  \item{gamma}{
parameter needed for all kernels except \code{linear}. See \code{\link{svm}} for more details.
}
  \item{coef0}{
parameter needed for kernels of type \code{polynomial} and \code{sigmoid}. See \code{\link{svm}} for more details.
}
  \item{cost}{
cost of constraints violation (default: 1) - it is the C-constant of the regularization term in the Lagrange formulation. See \code{\link{svm}} for more details.
}
  \item{nu}{
parameter needed for \code{nu-classification}. See \code{\link{svm}} for more details.
}
  \item{class.weights}{
a named vector of weights for the different classes, used for asymmetric class sizes. Not all factor levels have to be supplied (default weight: 1). All components have to be named. See \code{\link{svm}} for more details.
}
  \item{cachesize}{
cache memory in MB (default 40). See \code{\link{svm}} for more details.
}
  \item{tolerance}{
tolerance of termination criterion (default 0.001). See \code{\link{svm}} for more details.
}
  \item{epsilon}{
epsilon in the insensitive-loss function (default: 0.1). See \code{\link{svm}} for more details.
}
  \item{shrinking}{
option whether to use the shrinking-heuristics (default: \code{TRUE}). See \code{\link{svm}} for more details.
}
  \item{cross}{
if a integer value k>0 is specified, a k-fold cross validation on the training data is performed to assess the quality of the model: the accuracy rate for classification. See \code{\link{svm}} for more details.
}
  \item{probability}{
logical indicating whether the model should allow for probability predictions. See \code{\link{svm}} for more details.
}
  \item{fitted}{
logical indicating whether the fitted values should be computed and included in the model or not. See \code{\link{svm}} for more details.
}
  \item{seed}{
integer seed for \code{libsvm}. See \code{\link{svm}} for more details.
}
  \item{subset}{
an index vector specifying the cases to be used in the training sample. (NOTE: If given, this argument must be named). See \code{\link{svm}} for more details.
}
  \item{na.action}{
A function to specify the action to be taken if \code{NAs} are found. The default action is \code{na.omit}, which leads to rejection of cases with missing values on any required variable. An alternative is \code{na.fail}, which causes an error if \code{NA} cases are found. (NOTE: If given, this argument must be named). See \code{\link{svm}} for more details.
}
}
\details{
Internally, this function uses the \code{\link{svm}} function available in the \code{e1071} package.
}
\value{
\item{list}{An object to be used in \code{\link{classifyEEG}}.}
}
\references{
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.

Karatzoglou, A., Meyer, D., Hornik, K. (2006) Support Vector Machines in R. \emph{Journal of Statistical Software}. Vol 15, issue 9.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\seealso{
\code{\link{classifyEEG}}, \code{\link{FeatureEEG}}, \code{\link{svm}}
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
