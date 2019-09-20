### Set up connection
# sparkR must be loaded and session established
# before sparklyr it seems. 

library(SparkR)
library(sparklyr)
library(dplyr)

sparkR.session()

sc <- spark_connect(method = "databricks")

src_tbls(sc)

# Connect to an existing spark table
# example with dplyr

mytable <- tbl(sc, "mytable") 
mytable

# Do things
# some things

# write a file
# this writes as a hive table in parquet to the dbfs (databricks file system)
# set dir in dbfs as needed

spark_write_table(mytable, "my_spark_tbl")

# write a csv
# be aware this writes the hive partitions to multiple csv
# in the same folder, not a single csv file (hence no extension as it
# writes to a folder containing the csvs)

spark_write_csv(mytable, path = "dbfs:/mydir/mytable")

# use the databricks CLI to download the files to your local system

# Make sure that you have downloaded the databricks client by following the instructions here
# https://docs.databricks.com/user-guide/dev-tools/databricks-cli.html

