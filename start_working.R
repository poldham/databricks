### Set up connection
# sparkR must be loaded and session established
# before sparklyr it seems. 

library(SparkR)
sparkR.session()
library(sparklyr)
sc <- spark_connect(method = "databricks")
library(dplyr)
src_tbls(sc)

# Connect to an existing spark table
# example with dplyr

mytable <- tbl(sc, "mytable") 
mytable

# write a file to the file system
# this writes as a hive table in the dbfs (databricks file system)
# set dir in dbfs as needed

spark_write_table(mytable, "my_spark_tbl")

# write a csv
# be aware this writes the hive partitions to multiple csvs
# in the same folder, not a single csv file (hence no extension as it
# writes to a folder containing the csvs)

spark_write_csv(mytable, path = "dbfs:/mydir/mytable")

# use the databricks CLI to download the files to your local system
