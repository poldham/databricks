# load microsoft academic graph tables from dbfs for table joins

library(SparkR)
library(sparklyr)
library(dplyr)
library(tidyr)

# create connection
sparkR.session()
sc <- spark_connect(method = "databricks")

# source tables
# may need to arrange field names when loading
affiliations <- tbl(sc, "affiliations_grid_spark_tbl")
affiliations_papers <- tbl(sc, "affiliations_papers_spark_tbl")
papers <- tbl(sc, "papers_spark_tbl")
fos <- tbl(sc, "fos_spark_tbl") # check col format
fos_papers <- tbl(sc, "fos_papers_spark_tbl") # check col format
authors <- tbl(sc, "authors_spark_tbl")

# set the country

country_affiliation <- affiliations %>% 
  filter(countrycode = x) # x = country code

# join affiliations and papers tables

country_affiliation <- inner_join(affiliations, affiliation_papers, by = "affiliationid") %>% 
  inner_join(., papers, by = "paperid")

# for example

kenya_affiliations_papers <- inner_join(kenya, affiliations_papers, by = "affiliationid") %>% 
  inner_join(., papers, by = "paperid")