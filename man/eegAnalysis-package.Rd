\name{eegAnalysis-package}
\alias{eegAnalysis-package}
\alias{eegAnalysis}
\docType{package}
\title{
Feature selection and classification of electroencephalography data
}
\description{
This package consists of a set of tools to classify electroencephalography (EEG) and to successfully reduce the feature space dimension. More specifically, this package contains functions to simulate data (\code{randEEG}), to train classifiers (\code{svmEEG}), to classify new data (\code{classifyEEG}) and to plot data (\code{plotEEG} and \code{plotwindows}). Nevertheless, what differentiates this package from others available in the community are the functions to automatically select the best features to use in the classification model (\code{featureSelection} and \code{FeatureEEG}). 
}
\details{
\tabular{ll}{
Package: \tab eegAnalysis\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-04-08\cr
License: \tab GLP (>=2)\cr
}
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\references{
Bostanov, V. (2004) \emph{BCI Competition 2003 - Data Sets Ib and IIb: Feature Extraction From Event-Related Brain Potentials With the Continuous Wavelet Transform and the t-Value Scalogram.} IEEE transactions on biomedical engineering, V. 51, no. 6.

Brockwell, P.J., Davis, R.A. (2002) \emph{Introduction to Time Series and Forecasting}. 2nd ed. Colorado: Springer. Cap. 4.

Coutinho, M. (2013) \emph{Selecting features for EEG classification and constructions of Brain-Machine Interfaces.} Universidade de Brasilia (UnB), Master dissertation.
	
Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.

Karatzoglou, A., Meyer, D., Hornik, K. (2006) Support Vector Machines in R. \emph{Journal of Statistical Software}. Vol 15, issue 9.
}
\keyword{ EEG}
\keyword{ classification}
\keyword{ features}
\keyword{ SVM}
\keyword{ signals}
\keyword{feature selection}
