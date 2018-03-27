Purr tutorial
===
Author: Paula Andrea Martinez
Date: March 27th, 2018
Description: We are going to learn about functional programming using the R package `purrr`

## Target audience

R you new to R? let's dive into using a new set of tools from the [`tidyverse`](https://www.tidyverse.org/) package. Once you are familiar with using `dplyr`, `tidyr` and `ggplot2` you will probably feel the need to reduce duplication, and that's when `purrr` comes into the game.

R you an intermediate or advanced useR? have you written your own functions? Are you capable of using loops from base R? Have you used the functions from the `apply` family? R you ready for new underlying design philosophy to work with iterations in your code? I am happy to introduce you to `purrr`.

## Purrr is here for good!
"To solve many common iteration problems with less code, more ease, and fewer errors" [R for data science - Iteration](http://r4ds.had.co.nz/iteration.html). 

## Basic concepts
To get the best of this tutorial you need to understand some basic concepts
* R is a functional programming language.
* The major benefits of using `purrr` functions is not speed, but clarity.
* All `purrr` functions are implemented in C (but these also contain loops). (Notes: It's a wrapper - C loops are faster than R loops at the expense of readability.)
* Using `purrr` we can iterate through variables without knowing their length.
* Divide and conquer applies really well here: `purrr` guides you to break your challenges into independent small pieces. 

## Learn by doing

### Libraries
First we need our tools

    library(tidyverse)
    library(magrittr)
    
## It's worth the ride
Not so easy new concepts, but really worth the investment!
"The idea of passing a function to another function is extremely powerful idea"[R for data science - Iteration](http://r4ds.had.co.nz/iteration.html). 
