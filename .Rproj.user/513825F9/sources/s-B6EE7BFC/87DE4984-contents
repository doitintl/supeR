\name{supeR}
\alias{sqInitClient}
\alias{sqQuery}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
SuperR sqQuery
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
client <- sqInitClient()
res <-sqQuery(client, host="aaa", username="xxx", password="xxx", jobId = "yyy", sql="SELECT")
OR
client <- sqInitClient(host="aaa", username="xxx", password="xxx", jobId = "yyy", sql="SELECT")
res <-sqQuery(client, sql="SELECT")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{host}{
      The Hostname of the Super Query Server... Mostly bi.superquery.io
  }
  \item{username}{
      SuperQuery MySQL UserName
  }
  \item{password}{
      SuperQuery MySQL Password
  }
  \item{jobId}{
      SuperQuery JobId
  }
  \item{sql}{
      SuperQuery SQL Query Please note that table names need to enclosed by `
  }
}
\details{
Connect to Super Query and Query data. Data returns as data frame result and stats
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
R Packages: RMySQL
}
\author{
Corrie Painter
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
client <- sqInitClient()
res <-sqQuery(client, host="aaa", username="xxx", password="xxx", jobId = "yyy", sql="SELECT")
View(res@result)
View(res@stats)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
