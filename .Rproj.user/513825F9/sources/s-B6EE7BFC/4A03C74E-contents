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
    username = "character",
    password = "character",
    jobId = "character",
    conn = "MySQLConnection",
    result = "SuperQueryResult"
  ),
  prototype=list(
    host = "bi.superquery.io",
    port = 3306,
    username = Sys.getenv("SUPERQUERY_USERNAME"),
    password = Sys.getenv("SUPERQUERY_PASSWORD"),
    conn = NULL
  ),
)

#' @export
sqInitClient <- function(){
  new("SuperQueryClient")
}


setGeneric(name="sqQuery",
           def=function(client,
                        sql = NULL,
                        jobId = NULL,
                        host = NULL,
                        port = 3306,
                        username = NULL,
                        password = NULL)
           {
             standardGeneric("sqQuery")
           }
)

#' @export
#' @rdname SuperR
#' @importClassesFrom RMySQL MySQLConnection MySQLResult
setMethod("sqQuery", "SuperQueryClient", function(client,
                                               sql = NULL,
                                               jobId = NULL,
                                               host = NULL,
                                               port = 3306,
                                               username = NULL,
                                               password = NULL) {

  if (is.null(username) || !is.character(username)){
    if (!is.null(client@username) && is.character(client@username)){
      username <- client@username
    }else{
      stop("Argument username must be a string")
    }
  }
  if (is.null(password) || !is.character(password)){
    if (!is.null(client@password) && is.character(client@password)){
      password <- client@password
    }else{
      stop("Argument password must be a string")
    }
  }
  if (is.null(host) || !is.character(host)){
    if (!is.null(client@host) && is.character(client@host)){
      host <- client@host
    }else{
      stop("Argument host must be a string")
    }
  }
  if (is.null(jobId) || !is.character(jobId)){
    if (!is.null(client@jobId) && is.character(client@jobId)){
      jobId <- client@jobId
    }else{
      stop("Argument jobId must be a string")
    }
  }
  print("Connecting...")
  client@conn <- dbConnect(RMySQL::MySQL(),
                          host=host,
                          port=port,
                          username=username,
                          password=password)

  print("Connected!")
  #print(client@conn@Id)

  proj <- dbSendQuery(client@conn, paste("SET super_clientJobId =", jobId))
  print("Querying...")
  query <- dbSendQuery(client@conn, sql)
  queryResult <- dbFetch(query)
  dbClearResult(query)
  stats <- dbSendQuery(client@conn, "explain")
  queryStats <- dbFetch(stats)
  dbClearResult(stats)
  dbDisconnect(client@conn)
  print("Success!")
  new("SuperQueryResult", result=queryResult, stats = queryStats)

})

