# script for matching Lens microsoft_academic_id to paperid on a 
# Databricks Spark cluster using R. 

# this script works for the arctic dataset. The antarctic code is in the antarctic folder
# its the same but for the antarctic(!)

library(SparkR)
sparkR.session()
library(sparklyr)
sc <- spark_connect(method = "databricks")
library(dplyr)
src_tbls(sc)

# Connect to an existing spark table
# example with dplyr

# the paperid table is imported from mag_2019 folder onto the Spark cluster in Databricks

arctic_paperid_tbl <- tbl(sc, "arctic_paperid")

arctic_affiliation <- inner_join(arctic_paperid_tbl, affiliation_papers, by = "paperid") %>% 
  inner_join(., affiliations_grid, by = "affiliationid")

spark_write_table(arctic_affiliation, "arctic_affiliation_tbl")

arctic_authors <- inner_join(arctic_paperid_tbl, affiliation_papers, by = "paperid") %>% 
  inner_join(., authors, by = "authorid")

spark_write_table(arctic_authors, "arctic_authors_tbl")
