library(data.tree)
library(jsonlite)
m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')

l <- as.Node(m)
path <- '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate'

class(m2$Children)
m2$Climb(name = 'Children', position = 1)$path
m2$Get(name = 'Name')
cultivars <- Traverse(m2, filterFun = function(x) {
    if (is.null(x$Name))
        return(FALSE)
    if (x$Name == 'Cultivars' && x[['$type']] == 'Models.PMF.CultivarFolder, Models')
        return(TRUE)
    return(FALSE)
})

new_cultivar = Node$new(`$type` = "Models.PMF.Cultivar, Models",
                        Command = c("[Phenology].MinimumLeafNumber.FixedValue = 9",
                                    "[Phenology].VrnSensitivity.FixedValue = 7",
                                    "[Phenology].PpSensitivity.FixedValue = 3"),
                        Name = "New1",
                        Children = NULL,
                        IncludeInDocumentation = TRUE,
                        Enabled = TRUE,
                        ReadOnly = FALSE)
cultivars[[1]]$Children <- c(cultivars[[1]]$Children, new_cultivar)


cultivars[[1]]$Children$`9` <- new_cultivar
cultivars[[1]]$Children$`9`$Name
