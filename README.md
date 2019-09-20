# Databricks with RStudio using Github

This is an example repo for accessing and storing files in RStudio on the master node of a [Azure Databricks Spark Cluster](https://azure.microsoft.com/en-gb/services/databricks/). If you have found this repo you will probably have been reading the [excellent Databricks documentation](https://docs.databricks.com/) but are looking for more info for working with RStudio. 

The repo will help you to use Github to import files from a repo and to push files to a repo. If you are unfamiliar with Github read Jenny Bryan and Jim Hester's [Happy Git and GitHub for the useR](https://happygitwithr.com/).

If you are familiar with Github go directly to [Make A Repo on Github](https://happygitwithr.com/rstudio-git-github.html#make-a-repo-on-github-1). 
Copy the URL for your repo from the big green Clone button. Such as

`https://github.com/poldham/databricks.git`

Create a new project in RStudio > Version Control and enter the URL. 

Add the files you want to use on the cluster, commit and push to populate the repo.

Make sure you have a copy of the URL handy for the next step. 

When you have RStudio open on your master node. 

`Create New Project > Version Control > Paste URL and Name`

Follow the instructions in this repo in `setup_github.txt` to enable committing and pushing to the repo.

You can then access the files each time a new RStudio instance is created on the master node of the Cluster. 

To download files that you create or to move and delete them use the [Databricks CLI](https://docs.databricks.com/user-guide/dev-tools/databricks-cli.html). It is easy to use. 
