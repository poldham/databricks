# New databricks script reflecting actual workflow

# Setup Connection and Load Libraries -------------------------------------

# sparkR must be loaded and session established
# before sparklyr.  

library(SparkR)
sparkR.session()
library(sparklyr)
sc <- spark_connect(method = "databricks")
library(dplyr)
src_tbls(sc)

# Load MAG Spark Tables ---------------------------------------------------

authors <- tbl(sc, "authors_spark_tbl") %>% 
  rename(authorid = "_c0",
         authors_rankno = "_c1",
         authors_normalizedname = "_c2",
         authors_displayname = "_c3",
         authors_lastknownaffiliationid = "_c4",
         authors_papercount = "_c5",
         authors_citationcount = "_c6",
         authors_createdate = "_c7")

affiliation_papers <- tbl(sc, "affiliation_papers_spark_tbl") %>% 
  rename(paperid = "_c0", 
         authorid = "_c1", 
         affiliationid = "_c2", 
         authorsequencenumber = "_c3", 
         originalaffiliation = "_c4")

affiliations_grid <- tbl(sc, "affiliations_grid_spark_tbl")

fos <- tbl(sc, "fos_csv") # this is my own edited file with added values

fos_papers <- tbl(sc, "fos_papers_spark_tbl") %>%
  rename(paperid = "_c0", fieldofstudyid = "_c1", score = "_c2")

papers <- tbl(sc, "papers_spark_tbl") %>% 
  rename(paperid = "_c0", 
         paper_rankno = "_c1", 
         doi = "_c2",
         doctype = "_c3",
         papertitle = "_c4",
         originaltitle = "_c5",
         booktitle = "_c6",
         year = "_c7",
         date = "_c8",
         publisher = "_c9",
         journalid = "_c10",
         conferenceseriesid = "_c11",
         conferanceinstanceid = "_c12",
         volume = "_c13",
         issue = "_c14",
         firstpage = "_c15",
         lastpage = "_c16",
         referencecount = "_c17",
         paper_citationcount = "_c18",
         estimatedcitation = "_c19",
         originalvenue = "_c20",
         paper_createddate = "_c21")

nlp <- tbl(sc, "nlp_spark_tbl") %>% 
  rename(paperid = "_c0", indexedabstract = "_c1")


# Do things ---------------------------------------------------------------

# typically, source a table and then use inner join for shared records
# for example

biodiversity_tbl <- tbl(sc, "canada_biodiversity_paperid_csv")

biodiversity_affiliation <- inner_join(biodiversity_tbl, affiliation_papers, by = "paperid") %>% 
  inner_join(., affiliations_grid, by = "affiliationid")

# Wrte to DBFS ---------------------------------------------------------------

# write a table to file (as parquet). Download using the databricks CLI tool

spark_write_table(biodiversity_affiliation, "biodiversity_affiliation_tbl")
