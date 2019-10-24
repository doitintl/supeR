# supeR

![](https://web.superquery.io/wp-content/uploads/2019/03/sq-logotype@1x.svg)

# R package for superQuery

R Package for superQuery

# Getting Started

These instructions will get you up and running in RStudio to query data from SuperQuery. 

### Prerequisites

* RStudio

## Installation

Binary packages for __OS-X__ or __Windows__ can be installed directly from CRAN:

```r
install.packages("supeR")
```

The development version from github:

```R
# install.packages("devtools")
devtools::install_github("superquery/supeR")
devtools::install_github("r-dbi/RMySQL")
```
# Authentication
* Go to superquery.io and log in/sign up
* In the left side-bar, click on the "Integrations" icon
* Scroll down until you see "MySQL" and click "Connect"
* Note the username and password

# The basic flow
* Get your autentication details (See "Authentication" above)
* Import the supeR library: 

``` 
library(supeR)
``` 

* Create a superQuery client: 
``` 
client <- sqInitClient()
OR
client <- sqInitClient(host="aaa", port=0000, username="xxx", password="xxx")
```

* Set your Google Cloud billing project: 
```
projectId(client) <- "XYZ"
```

* Decide what SQL statement you'd like to run: 
``` 
query <- "SELECT name FROM `bigquery-public-data.usa_names.usa_1910_current` LIMIT 10"
```

* Get your results: 
```
res <- sqQuery(client,jobId = "yyy", sql=query)
OR
if client wasn't initialized with params then specify in sqQuery
res <- sqQuery(client, host="aaa", port=0000, username="xxx", password="xxx", jobId = "yyy", sql=query)
```

* View your results:
```
View(res@result)
```

* View your stats:
```
View(res@stats)
```

## Alternative supplying credentials
* Set these two variables in your local environment:
```
export SUPERQUERY_USERNAME=xxxxxx
export SUPERQUERY_PASSWORD=xxxxxx

Then init 
client <- sqInitClient()
res <- sqQuery(client,sql=query)
```


## Tested With

* [RStudio] Version 1.2.5001

## Authors

* **Corrie Painter** - *v1.0*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* The awesome people at superQuery
