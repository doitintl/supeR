\name{supeR}
\alias{sqQuery}
\alias{sqHost}
\alias{sqProjectId}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
SuperR sqQuery
}
\description{
To query SuperQuery.
Set environment variables
terminal:
export SUPERQUERY_USERNAME=xxxxxx
export SUPERQUERY_PASSWORD=xxxxxx
console:
> Sys.setenv(SUPERQUERY_USERNAME="xxxxxx")
> Sys.setenv(SUPERQUERY_PASSWORD="xxxxxx")

}
\usage{
res <-sqQuery(sql="SELECT",jobId="abc")
overrides :
client <- sqInitClient(host="aaa", projectId="yyy" jobId = "abc", sql="SELECT")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{jobId}{
      SuperQuery JobId
  }
  \item{sql}{
      SuperQuery SQL Query Please note that table names need to enclosed by `
  }
  \item{projectId}{
      Provide optional projectId
  }
  \item{host}{
      Override default Hostname of the Super Query Server... Mostly bi.superquery.io
  }
  \item{username}{
      Override environment variable Username
  }
  \item{password}{
      Override environment variable Password
  }
  \item{rowFetch}{
      Override default rowFetch default 500
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
Sys.setenv(SUPERQUERY_USERNAME="xxxxxx")
Sys.setenv(SUPERQUERY_PASSWORD="xxxxxx")

res <-sqQuery(sql="SELECT",jobId="abc")
View(res@result)
View(res@stats)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
