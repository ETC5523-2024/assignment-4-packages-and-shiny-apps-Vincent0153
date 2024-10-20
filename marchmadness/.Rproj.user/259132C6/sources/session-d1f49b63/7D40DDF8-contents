
<!-- README.md is generated from README.Rmd. Please edit that file -->

# marchmadness

<!-- badges: start -->
<!-- badges: end -->

The goal of marchmadness is to analyze each team’s performance and
determine whether historical performance will have an effect on public
picks for each team. Thus, this dataset could give you an insight and
enable you have a prediction on the final ranking of each team.

## Installation

You can install the development version of marchmadness from
[GitHub](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-Vincent0153/tree/main/marchmadness)
with:

``` r
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-Vincent0153", subdir = "marchmadness")
```

## Example

This is a basic example which shows you how to solve a common problem.
You can see the dataset by using following code.

``` r
library(marchmadness)
data("march_madness_dataset")
## basic example code
```

You can see the summary of the dataset using the following code:

``` r
summary(march_madness_dataset)
#>       YEAR          TEAMNO           TEAM                SEED      
#>  Min.   :2016   Min.   : 536.0   Length:512         Min.   : 1.00  
#>  1st Qu.:2018   1st Qu.: 671.8   Class :character   1st Qu.: 4.75  
#>  Median :2020   Median : 807.5   Mode  :character   Median : 8.50  
#>  Mean   :2020   Mean   : 807.9                      Mean   : 8.50  
#>  3rd Qu.:2022   3rd Qu.: 943.2                      3rd Qu.:12.25  
#>  Max.   :2024   Max.   :1079.0                      Max.   :16.00  
#>                                                                    
#>      ROUND           POWER           FINALS      
#>  Min.   : 0.00   Min.   :42.50   Min.   : 0.030  
#>  1st Qu.:16.00   1st Qu.:59.80   1st Qu.: 0.050  
#>  Median :32.00   Median :66.85   Median : 0.115  
#>  Mean   :37.34   Mean   :67.77   Mean   : 1.562  
#>  3rd Qu.:64.00   3rd Qu.:77.08   3rd Qu.: 0.640  
#>  Max.   :64.00   Max.   :92.30   Max.   :34.920  
#>                                  NA's   :448
```

## Shiny

You are also able to use the ShinyApp using the package. You can see
different shiny apps through two different functions below.

``` r
marchmadness::run_app() #OR
marchmadness::run_better_app()
```
