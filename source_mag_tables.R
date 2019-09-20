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
affiliation <- tbl(sc, "affiliations_grid_spark_tbl")
affiliation_papers <- tbl(sc, "affiliation_papers_spark_tbl")
papers <- tbl(sc, "papers_spark_tbl")
fos <- tbl(sc, "fos_spark_tbl") # check col format
fos_papers <- tbl(sc, "fos_papers_spark_tbl") # check col format
authors <- tbl(sc, "authors_spark_tbl")

# source the species dois table

mag_species_doi <- tbl(sc, "mag_species_doi")

# join the matches from the papers table onto the species table

species_doi_results <- inner_join(mag_species_doi, papers, by = "doi")

# write the table to the dbfs

spark_write_table(species_doi_results, "species_doi_results")


























# set the country

country_affiliation <- affiliations %>% 
  filter(countrycode = x) # x = country code

# join affiliations and papers tables

country_affiliation <- inner_join(affiliations, affiliation_papers, by = "affiliationid") %>% 
  inner_join(., papers, by = "paperid")

# for example

kenya_affiliations_papers <- inner_join(kenya, affiliations_papers, by = "affiliationid") %>% 
  inner_join(., papers, by = "paperid")