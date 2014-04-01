\name{randEEG}
\alias{randEEG}
\alias{print.RandEEG}
\alias{summary.RandEEG}
\title{
EEG simulation
}
\description{
Creates an object simulating ARIMA random variables. The created object contains data in the format required to use other methods of this package. Makes a simulation similar to EEG data to test the capabilities those methods. 
NOTE: The only purpose of the simulated data is to test the package features, it is not to be used to study properties of real EEG data!
}
\usage{
randEEG(n.classes = 2, n.rec = 10, n.channels = 20, n.signals = 250, 
ar="default", ma="default", order="default",vars = c(1, 2))
}
\arguments{
  \item{n.classes}{
number of different classes.
}
  \item{n.rec}{
number of recordings of each class.
}
  \item{n.channels}{
number of channels in the simulation.
}
  \item{n.signals}{
number of signals, observations or samples for each recording of each channel.
}
  \item{ar}{
is a matrix with AR coefficients of the ARIMA model. Each row contains the AR parameters for each class and each channel. One can make the number of rows in \code{ar} equal to the number of classes and, in this case, the function uses the same coefficients for all channels of each class. Another option is to choose the number of rows equal to \code{n.class*n.channels} and, in this case, the simulation uses different ARIMA models for each class and each channel. For example if we have 2 classes and \code{ar=matrix(c(0.1,0.5,-0.2,0.3,0,0),2,3,byrow=T)} then the first class will be simulated from an AR(3) and the second class will be simulated from an AR(1) with parameter 0.3.
}
  \item{ma}{
is a matrix with MA coefficients, defined the same way as \code{ar}. See the \code{ar} parameter for more information.
}
  \item{order}{
is a matrix with the same number of rows of \code{ar} and \code{ma} but with 3 columns. Thus, each line forms a vector which is used in the function \code{\link{arima.sim}}. For more information see the parameter \code{order} in the function \code{\link{arima.sim}}.
}
  \item{vars}{
a vector with length equal to the number of rows in \code{ar}, \code{ma} and \code{order}. Denote the variance for each ARIMA model.
}
}
\value{
\item{data}{the simulated data frame. The data frame is organized as follows: each column represents a different channel. Thus, each signal collected by each channel is represented in each row. To identify the class and recording represented by each line, the vectors \code{classes.Id} and \code{rec.Id} are given and have length equal to the number of rows in the data frame.} 
\item{classes.Id}{the vector indicating the class id of each row of \code{data}.} 
\item{rec.Id}{the vector indicating the recording id of each row of \code{data}.} 
\item{n.classes}{
number of different classes.
}
\item{n.rec}{number of recordings of each class.}
\item{n.channels}{
number of channels in the simulation.}
\item{n.signals}{
number of signals, observations or samples for each recording of each channel.
}
\item{vars}{
a vector with length equal to the number of rows in \code{ar}, \code{ma} and \code{order}. Denote the variance for each ARIMA model.
}
}
\references{
Brockwell, P.J., Davis, R.A. (2002) \emph{Introduction to Time Series and Forecasting}. 2nd ed. Colorado: Springer. Cap. 4.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\seealso{
\code{\link{plotEEG}}, \code{\link{arima.sim}}
}
\examples{
library(eegAnalysis)

#### Simulating EEG data
X<-randEEG(n.classes = 2, n.rec = 10, n.channels = 20, n.signals = 250, 
        vars = c(1, 2))


#### What do we have here?
names(X)


#### length of classes.Id and rec.Id are equal to the number of rows of data:
length(X$classes.Id)==nrow(X$data)
length(X$rec.Id)==nrow(X$data)


#### We have two classes:
unique(X$classes.Id)


#### We have 10 recordings for each class:
unique(X$rec.Id[which(X$classes.Id==1)])
unique(X$rec.Id[which(X$classes.Id==2)])


#### We have 20 channels:
ncol(X$data)


#### We have 250 signals for each class, recording and channel:
length(X$data[which(X$classes.Id==1 & X$rec.Id==1),1])

}
\keyword{ simulation }
\keyword{ EEG}
