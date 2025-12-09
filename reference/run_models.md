# Run apsimx file using Models.exe

Run apsimx file using Models.exe

## Usage

``` r
run_models(
  models_exe,
  path,
  pattern = NULL,
  recurse = FALSE,
  csv = FALSE,
  parallel = NULL,
  ncpus = NULL,
  verbose = FALSE
)
```

## Arguments

- models_exe:

  path to Models.exe

- path:

  The path to an .apsimx file. May include wildcard.

- pattern:

  Use to filter simulation names to run.

- recurse:

  Recursively search subdirectories for files matching ApsimXFileSpec.
  FALSE in default.

- csv:

  Export all reports to .csv files. FALSE in default.

- parallel:

  Use the multi-process job runner. If FALSE, use single threaded; if
  TRUE, use the multi-process job runner

- ncpus:

  Set the number of processors to use. All processes in default

- verbose:

  Write messages to StdOut when a simulation starts/finishes. Only has
  an effect when running a directory of .apsimx files (\*.apsimx).
