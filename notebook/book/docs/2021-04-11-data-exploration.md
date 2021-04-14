<!--- Timestamp to trigger book rebuilds: 2021-04-14 09:08:52 --->

## Apr. 15, 2021 (Data exploration)

<small>Source: <code>2021-04-11-data-exploration.Rmd</code></small>

Let's read in our cached dataset.


```r
library(tidyverse)
#> -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.3     v purrr   0.3.4
#> v tibble  3.1.0     v dplyr   1.0.5
#> v tidyr   1.1.3     v stringr 1.4.0
#> v readr   1.4.0     v forcats 0.5.1
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
data <- targets::tar_read(sleep_data)
```

This is the `sleepstudy` dataset [@belenky2003] from the lme4 package
[@lme4-paper]. It had repeated measurements of reaction times nested in
participants.


```r
head(data)
#> # A tibble: 6 x 3
#>   Reaction  Days Subject
#>      <dbl> <dbl>   <dbl>
#> 1     250.     0     308
#> 2     259.     1     308
#> 3     251.     2     308
#> 4     321.     3     308
#> 5     357.     4     308
#> 6     415.     5     308

count(data, Subject)
#> # A tibble: 18 x 2
#>    Subject     n
#>      <dbl> <int>
#>  1     308    10
#>  2     309    10
#>  3     310    10
#>  4     330    10
#>  5     331    10
#>  6     332    10
#>  7     333    10
#>  8     334    10
#>  9     335    10
#> 10     337    10
#> 11     349    10
#> 12     350    10
#> 13     351    10
#> 14     352    10
#> 15     369    10
#> 16     370    10
#> 17     371    10
#> 18     372    10

count(data, Days)
#> # A tibble: 10 x 2
#>     Days     n
#>    <dbl> <int>
#>  1     0    18
#>  2     1    18
#>  3     2    18
#>  4     3    18
#>  5     4    18
#>  6     5    18
#>  7     6    18
#>  8     7    18
#>  9     8    18
#> 10     9    18
```

We can plot all the participants' data.


```r
ggplot(data) + 
  aes(x = Days, y = Reaction) + 
  geom_line(aes(group = Subject)) + 
  stat_smooth(se = FALSE, method = "lm", size = 2, formula = y ~ x)
```

<img src="assets/figure/2021-04-11-data-exploration/spaghetti-1.png" title="Spaghetti plot of individual participant's data and group mean." alt="Spaghetti plot of individual participant's data and group mean." width="80%" style="display: block; margin: auto;" />
