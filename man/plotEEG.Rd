\name{plotEEG}
\alias{plotEEG}
\title{
Plot EEG data
}
\description{
This function was designed to do different types of plots of EEG data. Graphs of the original data, of the spectrum, continuous wavelet transform and t-value scalogram of the signals can be plotted. The main idea is to help the user to find nice features to use in his final model.
}
\usage{
plotEEG(data, classes.Id, rec.Id, which.classes = "ALL", which.rec = "ALL", 
which.channels = "ALL", type = "original", m.a = 1, n.colors = 200, 
wavelet = "gaussian2", abs = FALSE, Real = TRUE, variance = 1)
}
\arguments{
  \item{data}{
is the data frame containing the EEG signals. The data frame must be organized as follows: each column represents a different channel. Thus, the signals collected by each channel are represented in each row. To identify the class and recording represented by each line, the vectors \code{classes.Id} and \code{rec.Id} should be given and must have length equal to the number of rows in the data frame.
}
  \item{classes.Id}{
is a vector with length equal to the number of rows in \code{data}. Thus each value in the array identifies the class ID of each signal in each row of the database. For example, let \code{classes.Id = c(rep(1,5),rep(2,5))}, this means that the first 5 rows of \code{data} represents the class with ID 1 and the lines 6 to 10 represent the class with ID 2.
}
  \item{rec.Id}{
is a vector with length equal to the number of rows in \code{data}. Thus each value in the array identifies the recording ID of each signal in each row of the database. For example, let \code{rec.Id <- c(rep(1,5),rep(2,5))}, this means that the first 5 rows of \code{data} represents the recording with ID 1 of some class and the lines 6 to 10 represent the recording with ID 2 of some class. \code{rec.Id} must be numeric and numerated from 1 to the total number of recordings for each class.
}
  \item{which.classes}{
a vector representing which classes will be plotted. For example, if \code{which.classes=} \code{c(1,3)} then the classes with ID 1 and 3 will be plotted (indicated by the vector \code{classes.Id}). If \code{which.classes=} \code{"ALL"} then all classes will be plotted. Obs: if \code{type = "T.pvalue"} then only two classes are allowed.
}
  \item{which.rec}{
a list representing which recordings shall be plotted for each class. For example, if \code{which.rec=} \code{list(c(1,3,4),c(1,2,4))}  then the recordings with ID 1,3 and 4 will be plotted for the first class indicated in the vector \code{which.classes} and the recordings with ID 1,2 and 4 will be plotted for the second class indicated in the vector \code{which.classes}. If \code{which.rec="ALL"} then all recordings will be plotted.
}
  \item{which.channels}{
a vector representing which channels shall be plotted. For example, if \code{which.channels} \code{=c(1,3)} then the channels 1 and 3 (columns 1 and 3 of \code{data}) will be plotted. If \code{which.channels="ALL"} then all channels will be plotted.
}
  \item{type}{
if \code{type="original"} then the original recordings will be plotted, if \code{type=} \code{"spectrum"} then the spectrum of each recording will be plotted, if \code{type="wavelet"} then the continuous wavelet transform matrix of the recordings will be plotted, if \code{type="T.pvalue"} then the t-value scalogram of the recordings will be plotted (see Bostanov 2004). 
}
  \item{m.a}{
is the moving average parameter, if \code{m.a=1} it is not used. If \code{type=} \code{"original"} then the moving average is applied for each channel of the original recordings. If \code{type=} \code{"spectrum"} and \code{m.a} is a number, the moving average is applied on the spectrum of the recordings, otherwise, if \code{m.a} is a vector of size 2, the first value defines the moving average for the original recordings and the second value defines the moving average for the spectrum. If \code{type=} \code{"wavelet"} or \code{"T.pvalue"}, \code{m.a} should be a vector of size 2, indicating the dimensions in which the moving average will be applied on the CWT matrix.
}
  \item{n.colors}{
is the number of colors for the contour plot. Used if \code{type="wavelet"} or \code{type=} \code{"T.pvalue"}.
}
  \item{wavelet}{
if \code{type="wavelet"} defines which wavelet is used. See \code{\link{wavCWT}} for more details.
}
  \item{abs}{
if TRUE then the absolute value of the continuous wavelet transform matrix is used.  Used if \code{type="wavelet"} or \code{type="T.pvalue"}.
}
  \item{Real}{
if TRUE takes the real part of the continuous wavelet transform matrix, if FALSE takes the imaginary part. Used if \code{wavelet="morlet"}.
}
  \item{variance}{
the variance parameter for the continuous wavelet transform. See \code{\link{wavCWT}} for more details.
}
}
\references{
Bostanov, V. (2004) \emph{BCI Competition 2003 - Data Sets Ib and IIb: Feature Extraction From Event-Related Brain Potentials With the Continuous Wavelet Transform and the t-Value Scalogram.} IEEE transactions on biomedical engineering, V. 51, no. 6.

Hastie, T., Tibshirani, R., Friedman, J. (2009) \emph{The Elements of Statistical Learning: Data Mining, Inference, and Prediction.} 2nd ed. Stanford: Springer.

Brockwell, P.J., Davis, R.A. (2002) \emph{Introduction to Time Series and Forecasting}. 2nd ed. Colorado: Springer. Cap. 4.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}

\seealso{
\code{\link{wavCWT}}, \code{\link{spectrum}}
}
\examples{
library(eegAnalysis)

#### Simulating some data
sim<-randEEG()

#### Plot some of the recordings:
plotEEG(sim$data, sim$classes.Id, sim$rec.Id, which.classes = "ALL", 
        which.rec=list(c(1,2,3),c(2,3,4)), which.channels=c(1,2,3), 
        type = 'original', m.a = 10) 


#### Plot the spectrum
plotEEG(sim$data, sim$classes.Id, sim$rec.Id, which.classes = "ALL", 
        which.rec="ALL", which.channels=1, type = 'spectrum', m.a = 10) 


#### Plot the spectrum 
plotEEG(sim$data, sim$classes.Id, sim$rec.Id, which.classes = "ALL", 
        which.rec="ALL", which.channels=5, type = 'spectrum', m.a = c(5,20)) 


#### Plot the continuous wavelet transform
plotEEG(sim$data, sim$classes.Id, sim$rec.Id, which.classes = 1, 
        which.rec=list(c(1)), which.channels=c(2), type = 'wavelet',
        wavelet="gaussian2", abs=TRUE,variance=1) 


### Plot the T-value scalogram
plotEEG(sim$data, sim$classes.Id, sim$rec.Id, which.classes = "ALL", 
        which.rec="ALL", which.channels=c(2), type = 'T.pvalue', 
        wavelet="gaussian2", abs=TRUE,variance=10) 

}
\keyword{ plot}
\keyword{ EEG}
