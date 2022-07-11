
#' List all reports in the database
#'
#' @param file the file path to apsimx or db file
#'
#' @return a vector of all reports
#' @export
#'
#' @examples
#' file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
#' list_report(file)
list_report <- function(file) {
    if (length(file) != 1) {
        stop("only support single file")
    }
    if (tools::file_ext(file) == "apsimx") {
        file <- paste0(tools::file_path_sans_ext(file), ".db")
    }
    if (tools::file_ext(file) != "db") {
        stop("Require a db file")
    }
    if (!file.exists(file)) {
        stop("File does not exist: ", file)
    }
    con <- DBI::dbConnect(RSQLite::SQLite(), file)
    tbls <- RSQLite::dbListTables(con)
    DBI::dbDisconnect(con)
    system_tbls <- c("_Checkpoints",
                     "_Factors", "_InitialConditions",
                     "_Messages", "_Simulations")
    tbls[!(tbls %in% system_tbls)]
}

#' Read apsimx database in db file format
#'
#' @param file the file path to apsimx or db file
#' @param report the report name
#'
#' @return a data.frame for a report
#' @export
#'
#' @examples
#' file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
#' read_report(file, "HarvestReport")
read_report <- function(file, report) {
    if (length(file) != 1) {
        stop("only support single file")
    }
    if (length(table) != 1) {
        stop("Only support single table")
    }
    if (tools::file_ext(file) == "apsimx") {
        file <- paste0(tools::file_path_sans_ext(file), ".db")
    }
    if (tools::file_ext(file) != "db") {
        stop("Require a db file")
    }
    if (!file.exists(file)) {
        stop("File does not exist: ", file)
    }
    con <- DBI::dbConnect(RSQLite::SQLite(), file)
    tbls <- RSQLite::dbListTables(con)
    if (!(report %in% tbls)) {
        message("The tables include: ", paste(tbls, collapse = ", "))
        DBI::dbDisconnect(con)
        stop("Cannot find table ", report, " in the database.")
    }
    simulations <- DBI::dbReadTable(con, "_Simulations") %>% tibble::tibble()
    table_con <- DBI::dbReadTable(con, report) %>% tibble::tibble()
    common_cols <- c("SimulationID" = "ID")
    if (rlang::has_name(table_con, "FolderName")) {
        common_cols <- c(common_cols, "FolderName")
    }
    table_con <- table_con %>%
        dplyr::left_join(simulations, by = common_cols)
    DBI::dbDisconnect(con)
    table_con
}
