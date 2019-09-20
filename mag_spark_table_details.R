# a script and or functions to load tables and make the joins required for country analysis
# to avoid the normalizedname.x and .y problem assign names to tables using table prefixes. 
# They are typically not join fields (as joins are on id fields)
# load tables
library(dplyr)

# authors table

authors <- tbl(sc, "authors_spark_tbl") %>% 
  rename(authorid = "_c0",
         authors_rankno = "_c1",
         authors_normalizedname = "_c2",
         authors_displayname = "_c3",
         authors_lastknownaffiliationid = "_c4",
         authors_papercount = "_c5",
         authors_citationcount = "_c6",
         authors_createdate = "_c7")

# affiliation to papers table link
# enables joins on paperid with authors (authorid) and affiliations (affiliationid)
# use originalaffiliation to improve coverage

affiliation_papers <- tbl(sc, "affiliation_papers_spark_tbl") %>% 
  rename(paperid = "_c0", 
         authorid = "_c1", 
         affiliationid = "_c2", 
         authorsequencenumber = "_c3", 
         originalaffiliation = "_c4")

# a table of author affiliations that possess a GRID id 
# Global Researcher Identifier Id database

affiliations_grid <- tbl(sc, "affiliations_grid_spark_tbl")

# fields of study
# contains the field of study names and ids for table joins
# this has added columns from the original

fos <- tbl(sc, "fos_csv") # this is my edited file with added values

# links
fos_papers <- tbl(sc, "fos_papers_spark_tbl") %>%
  rename(paperid = "_c0", 
         fieldofstudyid = "_c1", 
         score = "_c2")

# papers

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

# nlp
# A large table that contains inverted index of the Abstracts
# only load if needed

nlp <- tbl(sc, "nlp_spark_tbl") %>% 
  rename(paperid = "_c0", 
         indexedabstract = "_c1")




