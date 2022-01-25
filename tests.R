## execute all code in the solution file
solution_filenames <- Sys.glob("*_solution.Rmd")

solution_tests <- function(n){
  expect_error(knitr::knit(text=readLines(solution_filenames[!!n])), NA)
  expect_equal(nrow(flights_sm), 284170)
  expect_vector(flights_sm$seat_miles, numeric())
  expect_equal(nrow(sm_max), 16)
  expect_true(all(diff(sm_max$seat_miles)<=0))
  expect_equal(dim(sm_dest), c(104, 9))
}

test_that(sprintf("checking first solution file: %s", solution_filenames[1]), {
  solution_tests(1)
})

if(length(solution_filenames) > 1 | system("git rev-parse --abbrev-ref HEAD", intern=TRUE) == "main"){
  test_that(sprintf("checking second solution file: %s", solution_filenames[2]), {
    solution_tests(2)
  })
}