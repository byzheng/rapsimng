# Install ApsimNG Software

This function installs the ApsimNG simulation software on the local
system. It handles the download and installation process for the APSIM
Next Generation agricultural modeling platform.

## Usage

``` r
install_apsimng(
  repo = "https://github.com/APSIMInitiative/ApsimX.git",
  branch = "master",
  install_dir = "apsimx_build",
  overwrite = FALSE
)
```

## Arguments

- repo:

  Character string specifying the repository of ApsimNG to install.

- branch:

  Character string specifying the branch of the repository to install.

- install_dir:

  Character string specifying the directory where ApsimNG should be
  installed.

- overwrite:

  Logical. If TRUE, overwrites any existing installation at the
  specified install directory.

## Value

No return value.

## Details

This function downloads and installs ApsimNG from the official
repository. It performs version checking, handles dependencies, and
configures the installation for use with R. The function requires
administrative privileges on Windows systems.

## Examples

``` r
if (FALSE) { # \dontrun{
# Install latest version
install_apsimng()
install_apsimng(install_dir = "C:/MyPrograms/ApsimNG")
} # }
```
