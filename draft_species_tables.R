# draft tables for species landscape in scientific literature
# use the rough ids table to join paperid to affiliation and other tables

# source the rough id table
# note that paperid is double in tables

species_found_id <- tbl(sc, "species_found_rough_id_spark") %>% 
  mutate(paperid = as.numeric(paperid))

# obtain affiliation ids with original affiliation for join to GRID table
species_rough_affiliation <- inner_join(species_found_id, affiliation_papers, by = "paperid")
species_rough_grid <- inner_join(species_rough_affiliation, affiliation, by = "affiliationid")

# obtain fields of study
# this obtains the field of study id for each paper
species_rough_fosid <- inner_join(species_found_id, fos_papers, by = "paperid")

# authors
# use for match validation with OAG version along with year and title
# the join is from the affiliation_papers to the authors table

species_rough_authors <- inner_join(species_rough_affiliation, authors, by = "authorid")

# write files to csv in filestore

spark_write_csv(species_rough_affiliation, "species_rough_affiliation_csv")
spark_write_csv(species_rough_grid, "species_rough_grid_csv")
spark_write_csv(species_rough_fosid, "species_rough_fosid_csv")
spark_write_csv(species_rough_authors, "species_rough_authors_csv")
                


