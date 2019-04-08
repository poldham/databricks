# NB - these are draft outlines for possible functions
# microsoft academic graph common joins

# obtain the papers associated with a country in the affiliations table

country_papers <- function(x, countrycode){
  x = affiliations_grid %>% 
    dplyr::filter(countrycode = x) %>% # note tidyevaluation issue to test here
    dplyr::inner_join(., affiliation_papers, by = "affiliationid") %>% 
    dplyr::inner_join(., papers, by = "paperid")
}

# take output of country papers and feed into
country_authors <- function(x){
  x <- dplyr::inner_join(country_papers, authors, by = "authorid")
  # check for .x
}

# take output of country papers
# be aware that for fos there will is duplication of the paperid where more than one
# author from the same institution is listed. This will duplicate across the fos data. 
# for that reason use distinct on the paperid prior to the join.
country_fos <- function(x){
  input <- x %>% distinct(paperid)
  out <- inner_join(country_papers_unique, fos_papers, by = "paperid")
}
