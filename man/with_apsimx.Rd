% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_models.R
\name{with_apsimx}
\alias{with_apsimx}
\title{Run APSIM Next Generation Simulations in a Temporary Folder}
\usage{
with_apsimx(
  models,
  file,
  mets = NULL,
  target = tempdir(),
  clean = c("none", "simulations", "mets", "all"),
  post_process = NULL,
  ...
)
}
\arguments{
\item{models}{A character string specifying the path to the APSIM NG executable (`Models.exe` on Windows
or `Models` on Linux).}

\item{file}{A character string specifying the path to the `.apsimx` simulation file.}

\item{mets}{A character vector specifying paths to meteorological data (`.met` files) used in the simulation.
Currently, only `.met` files located in the same folder as the `.apsimx` file are supported (optional).}

\item{target}{A character string specifying the target directory where simulations will be run.
Defaults to the R system temporary directory (`tempdir()`).}

\item{clean}{A character string specifying which files or directories to clean after the simulation. Options are:
\itemize{
  \item `"none"`: No files are cleaned (default).
  \item `"simulations"`: Cleans only simulation-related files (e.g., `*.apsimx`, `*.db`, `*.db-shm`, `*.db-wal`, `*.csv`).
  \item `"mets"`: Cleans only meteorological files (e.g., `*.met`).
  \item `"all"`: Cleans all files, including APSIM NG executable files, simulations, and meteorological files.
}}

\item{post_process}{An optional function for post-processing simulation results.
The function must accept a `folder` argument specifying the directory
containing the simulation results.}

\item{...}{Additional arguments passed to both the `run_models` and `post_process` functions.}
}
\value{
If a `post_process` function is provided, its return value is returned. Otherwise, the function returns `NULL`.
}
\description{
The `with_apsimx` function automates the process of setting up and running APSIM Next Generation (NG) simulations
in a temporary or specified folder. This approach helps reduce I/O overhead, particularly in high-performance
computing (HPC) environments with network file systems (NFS). The frequent file I/O operations performed by APSIM NG
(e.g., writing to SQLite databases) can strain file systems, and redirecting simulations to a local folder mitigates this issue.
The function can also perform optional post-processing of the simulation results.
}
\examples{
\dontrun{
# Run simulations without post-processing
with_apsimx(
    models = "path/to/apsimx",
    file = "path/to/input.apsimx",
    mets = c("path/to/met1.met", "path/to/met2.met"),
    clean = "all"
)

# Run simulations with post-processing
post_process_function <- function(folder) {
    output_files <- list.files(folder, full.names = TRUE)
    message("Output files:", paste(output_files, collapse = "\n"))
}

result <- with_apsimx(
    models = "path/to/apsimx",
    file = "path/to/input.apsimx",
    mets = c("path/to/met1.met", "path/to/met2.met"),
    post_process = post_process_function
)
}

}
\seealso{
\code{\link{run_models}}: Runs APSIM simulations.
\code{\link{do.call}}: Dynamically calls functions with named arguments.
}
