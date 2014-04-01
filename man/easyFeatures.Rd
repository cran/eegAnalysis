\name{easyFeatures}
\alias{easyFeatures}
\alias{print.Features}
\alias{summary.Features}
\title{
Choosing Features
}
\description{
This function helps the user to produce an object of class \code{Features}. The purpose of this object is to be used in the function \code{\link{FeatureEEG}} as the parameter \code{features}. It is possible to construct this object "by hand" but it can be a difficult task. It takes some time to choose all the features, so it is recommended to save the object afterwards.
}
\usage{
easyFeatures()
}
\references{
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}

\seealso{
 \code{\link{FeatureEEG}}
}
\examples{
#### This example have to be uncommented to be used

#### Use the function
# features<-easyFeatures()

#### Save your features
# dump("features", file = "example.R")

#### In this case, you can find your features in your current directory
# getwd()

#### Read your features again if you need to:
# source("example.R")
}
\keyword{features}
