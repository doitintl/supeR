#' @rdname SuperR
#' @export
#'
setClass(
  "SuperQueryResult",
  contains = "data.frame",
  slots = list(
    result = "data.frame",
    stats = "data.frame"
  )
)

#' @rdname SuperR
#' @export
#' @importClassesFrom RMySQL MySQLConnection
setClass(
  "SuperQueryClient",
  slots = list(
    host = "character",
    port = "numeric",
    rowFetch = "numeric",
    username = "character",
    password = "character",
    projectId = "character",
    userAgent = "character",
    conn = "MySQLConnection",
    result = "SuperQueryResult"
  ),
  prototype=list(
    host = "bi.superquery.io",
    port = 3306,
    username = Sys.getenv("SUPERQUERY_USERNAME"),
    password = Sys.getenv("SUPERQUERY_PASSWORD"),
    userAgent = "proxyApi",
    rowFetch = 500,
    projectId = NULL
  ),
)

# Getter for ProjectId
#' @export
setGeneric("sqProjectId", function(x) standardGeneric("sqProjectId"))
#' @export
setMethod("sqProjectId","SuperQueryClient",function(x){
  x@projectId
})

# Setter for ProjectId
#' @export
setGeneric("sqProjectId<-", function(x,value) standardGeneric("sqProjectId<-"))
#' @export
setMethod("sqProjectId<-","SuperQueryClient",function(x,value){
  x@projectId <- value
  x
})

# Getter for userAgent
#' @export
setGeneric("sqUserAgent", function(x) standardGeneric("sqUserAgent"))
#' @export
setMethod("sqUserAgent","SuperQueryClient",function(x){
  x@userAgent
})

# Setter for userAgent
#' @export
setGeneric("sqUserAgent<-", function(x,value) standardGeneric("sqUserAgent<-"))
#' @export
setMethod("sqUserAgent<-","SuperQueryClient",function(x,value){
  x@userAgent <- value
  x
})

# Getter for sqHost
#' @export
setGeneric("sqHost", function(x) standardGeneric("sqHost"))
#' @export
setMethod("sqHost","SuperQueryClient",function(x){
  x@host
})

# Setter for userAgent
#' @export
setGeneric("sqHost<-", function(x,value) standardGeneric("sqHost<-"))
#' @export
setMethod("sqHost<-","SuperQueryClient",function(x,value){
  x@host <- value
  x
})


setGeneric(name="sqQuery",
           def=function(sql = NULL,
                        jobId = NULL,
                        host = NULL,
                        projectId = NULL,
                        username = NULL,
                        password = NULL)
           {
             standardGeneric("sqQuery")
           }
)

#' @export
#' @rdname SuperR
#' @importClassesFrom RMySQL MySQLConnection MySQLResult
sqQuery <- function(sql = NULL,
                    jobId = NULL,
                    host = NULL,
                    projectId = NULL,
                    username = NULL,
                    password = NULL,
                    rowFetch = NULL){
  # Initialize client...

  client <- new("SuperQueryClient")

  if (!is.null(username) && is.character(username)){
    client@username <- username
  }
  if (!is.null(password) && is.character(password)){
    client@password <- password
  }
  if (!is.null(rowFetch) && is.numeric(rowFetch)){
    client@rowFetch <- rowFetch
  }

  if (client@username == "" || is.null(client@username) || !is.character(client@username)){
    stop("Please provide valid credentials as environment variables ")
  }
  if (client@password == "" || is.null(client@password) || !is.character(client@password)){
    stop("Please provide valid credentials as environment variables ")
  }
  if (jobId == "" || is.null(jobId) || !is.character(jobId)){
    stop("Argument jobId must be a string")
  }
  if (!is.null(host) && host != "" && is.character(host)){
    sqHost(client)<- host
  }
  if (!is.null(projectId) && projectId != "" && is.character(projectId)){
    sqProjectId(client)<- projectId
  }

  print("Connecting...")
  client@conn <- dbConnect(RMySQL::MySQL(),
                          host=client@host,
                          port=client@port,
                          username=client@username,
                          password=client@password)

  print("Connected!")
  #print(client@conn@Id)
  if (!is.null(client@projectId)){
    print("Setting projectId...")
    projId <- dbSendQuery(client@conn, paste("SET super_projectId=", client@projectId))
  }

  proj <- dbSendQuery(client@conn, paste("SET super_clientJobId =", jobId))
  if (!is.null(client@userAgent)){
    print("Setting userAgent...")
    proj <- dbSendQuery(client@conn, paste("SET super_userAgent =", client@userAgent))
  }
  print("Querying...")
  query <- dbSendQuery(client@conn, sql)

  l <- vector("list", dbGetRowCount(query))
  while(!dbHasCompleted(query)){
    chunk <- dbFetch(query, n = client@rowFetch)
    l <- rbind (l, chunk)
  }
  queryResult <- l
  dbClearResult(query)
  stats <- dbSendQuery(client@conn, "explain")
  queryStats <- dbFetch(stats)
  dbClearResult(stats)
  dbDisconnect(client@conn)
  print("Success!")
  new("SuperQueryResult", result=queryResult, stats = queryStats)

}
