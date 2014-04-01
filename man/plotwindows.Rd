\name{plotwindows}
\alias{plotwindows}
\alias{print.plotwindows}
\alias{summary.plotwindows}
\alias{plot.plotwindows}
\title{
Plot statistics calculated by windows
}
\description{
This function was designed to do charts of EEG data. Basically, the data (for each channel, class and recording) is divided by windows and a statistical function (as the mean or variance) is applied for all signals in each window. Then, the sequence of values obtained for each window is plotted.
}
\usage{
plotwindows(data, classes.Id, rec.Id, which.classes = "ALL", 
which.rec = "ALL", which.channels = "ALL", win = 10, stat = "sum", 
power = 2, abs = FALSE, log = FALSE, complete = FALSE, mintomax = FALSE)
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
a vector representing which channels shall be plotted. For example, if \code{which.channels} \code{=c(1,3)} then the channels 1 and 3 (columns 1 and 3 of \code{data}) will be plotted. If \code{which.channels ="ALL"} then all channels will be plotted.
}
 \item{win}{
the window size.
}
 \item{stat}{
is the statistic applied on the signals of each window. If \code{stat=} \code{"sum"} then the sum is used. If \code{stat="mean"} then the mean is used. If \code{stat="var"} then the variance is used. If \code{stat="sd"} then the standard deviation is used. If \code{stat="max"} then the maximum value is used. If \code{stat="min"} then the minimum value is used. If \code{stat="prod"} then the product is used. If \code{stat=} \code{"median"} then the median is used. If \code{stat="geometric"} then the geometric mean is used. If \code{stat="harmonic"} then the harmonic mean is used. 
}
 \item{power}{
a transformation of the data can be performed before using the chosen statistic. In this case the transformation will be \code{data^power}. OBS: watch out for negative values if \code{power} is not an integer!
}
  \item{abs}{
a transformation of the data can be used before using the chosen statistic, in this case, if \code{abs=TRUE}, then the transformation will be \code{abs(data)^power}.
}
  \item{log}{
a transformation of the data can be used before using the chosen statistic, in this case, if \code{log=TRUE} and \code{abs=TRUE}, then the transformation will be \code{log(abs(data)} \code{^power+1)}. OBS: watch out for negative values if \code{abs=} \code{FALSE}  
}
  \item{complete}{
if \code{complete=FALSE}, then the windows will be completely separated. For example, if \code{win=10} then the first window will consist of signals 1 to 10, the second window will consist of signals 11 to 20, and so on. If \code{complete=TRUE}, then some signals will overlap in consecutive windows. For example, if \code{win=10} then the first window will consist of observations 1 to 10, the second window will consist of observations 2 to 11, the third will consist of observations 3 to 12, and so on.  
}
  \item{mintomax}{
if \code{mintomax=FALSE} then the function will plot each obtained value for each window in order. If \code{mintomax=TRUE} then the function will sort the obtained values for each window and then plot these values from minimum to maximum, and thus, providing a quantile analysis. 
}  
}
\value{
  \item{data}{Is a data frame with all the statistics computed by the function for each window. Arranged in the same way as the input parameter \code{data}.}    
  \item{classes.Id}{Is a vector with the same meaning as the input parameter \code{classes.Id} but related to the output parameter \code{data}.}
  \item{rec.Id}{Is a vector with the same meaning as the input parameter \code{rec.Id} but related to the output parameter \code{data}.}
}
\references{
Brockwell, P.J., Davis, R.A. (2002) \emph{Introduction to Time Series and Forecasting}. 2nd ed. Colorado: Springer. Cap. 4.
}
\author{
Murilo Coutinho Silva (coutinho.stat@gmail.com), George Freitas von Borries
}
\seealso{
  \code{\link{plotEEG}}
}
\examples{
library(eegAnalysis)


### Simulating a data set
sim<-randEEG()


### Plotting the sum of the signals in windows of size 10
plotwindows(sim$data, sim$classes.Id , sim$rec.Id , which.classes = "ALL", which.rec="ALL",
            which.channels=c(1), win=10, stat="sum", power = 2, abs=FALSE, 
            log=FALSE,complete = FALSE, mintomax=FALSE) 

### Plotting the sorted sum of the signals in windows of size 10
plotwindows(sim$data, sim$classes.Id , sim$rec.Id , which.classes = "ALL", which.rec="ALL",
            which.channels=c(1), win=10, stat="sum", power = 2, abs=FALSE, 
            log=FALSE,complete = FALSE, mintomax=TRUE) 

}
\keyword{plot}
\keyword{EEG}
