
rm(list = ls())
# Convert modelx.xml into a list
file <- "script/Models.xml"
if (!file.exists(file)) {
    stop("Models.xml doesn't exist.")
}
doc <- xml2::read_xml(file)
# List of all models
m <- xml2::xml_find_all(doc, paste0('//member[contains(@name,"T:Models.")]'))
m <- xml2::xml_attr(m, "name")
m <- gsub("T:Models\\.", "", m)

all_models <- list()
i <- 1
# Generate new modesl with default name
for (i in seq(along = m)) {
    mm <- xml2::xml_find_first(doc, paste0('//member[@name="T:Models.', m[i], '"]'))
    if (length(mm) == 0) {
        stop("Cannot find the models with name ", model)
    }
    res <- list()
    res[["$type"]] <- paste0("Models.", m[i], ", Models")

    res$Name <- m[i]
    res$Children <- list()
    res$IncludeInDocumentation <- TRUE
    res$Enabled <- TRUE
    res$ReadOnly <- FALSE
    # Find attributes
    path <- paste0("//member[contains(@name, 'P:Models.",  m[i], "')]")
    members <- xml2::xml_find_all(doc, xpath = path)
    for (j in seq(along = members)) {
        attr_name <- xml2::xml_attr(members[[j]], "name")
        attr_name <- gsub(paste0("P:Models\\.", m[i], '\\.(.+)'), '\\1', attr_name)
        res[[attr_name]] <- list()
    }
    all_models[[m[i]]] <- res
}

saveRDS(all_models, "inst/Models.Rds")
