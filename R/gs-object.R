gs_object <- function(bucket, object) {
  structure(
    list(bucket = bucket, object = object),
    class = "gs_object"
  )
}

#' @export
as.character.gs_object <- function(x, ...) {
  format(x)
}

#' @export
format.gs_object <- function(x, ...) {
  as.character(glue::glue_data(x, "gs://{bucket}/{object}"))
}

#' @export
print.gs_object <- function(x, ...) {
  cat_line("<gs_object> ", format(x))
  invisible(x)
}

gs_object_delete <- function(x, token = get_access_cred()) {
  url <- glue::glue_data(x, "https://www.googleapis.com/storage/v1/b/{bucket}/o/{object}")
  req <- httr::DELETE(url, config(token = token), httr::user_agent(bq_ua()))
  process_request(req)
}

gs_object_exists <- function(x, token = get_access_cred()) {
  url <- glue::glue_data(x, "https://www.googleapis.com/storage/v1/b/{bucket}/o/{object}")
  req <- httr::GET(url, config(token = token), httr::user_agent(bq_ua()))
  req$status_code != 404
}
