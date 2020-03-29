 # EDH Intructions
 Instructions for running the code on your CDSW instance
- [ ] Create a fork of the project
- [ ] Setup your CDSW project using the git report
- [ ] Start a session and run the Ipak.R script to install the dependencies
- [ ] Setup the tables in EDH using Impala

## Run the model
To run the model agains the local dataset to test
`stoch_model_V2_paper/srcipts/main_model.R`

## To run against using the EDH Yarn Cluster
First load the data onto the Cluster, open a Terminal
`hdfs dfs -put data/* ncov2020/data/`

Alternatively we could run directly in the R using the CDSW console
`system("hdfs dfs -put data/* ncov2020/data/")`

Note we'll switch over these directories to more current datasets as we get them loaded. We'll load the data into Impala tables

Then run the main model_functions
`EDH_v1\scripts\main_model.R`
