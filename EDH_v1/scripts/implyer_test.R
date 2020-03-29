# test Impala with R
# Based on https://dzone.com/articles/implyr-r-interface-for-apache-impala

library(odbc)
library(implyr)
library(dplyr)

# Create the ODBC driver

drv <- odbc::odbc()

# Call the Impala driver
# kinit using your details kinit $USER@$REALM
# Change the Hostname
impala <- src_impala(
 drv = drv,
 driver = "Cloudera ODBC Driver for Impala",
 host = "hostname",
 port = 21050,
 database = "u_ndunnage",
 #uid = "username",
 #pwd = "password",
 AuthMech = "Kerberos",
 KrbRealm = "PROD.EDH",
 KrbServiceName = "impala",
 SSL = "1"
)

# List the tables in the database
src_tbls(impala)

# Create and R Object based on the Impala Table
international_case_data <- tbl(impala, "international_case_data")

# To specify in the database
international_case_data <- tbl(impala, in_schema("u_ndunnage", "international_case_data"))

# Run a query using dplyr
international_case_data %>%
  filter(country %like% "%China%") %>%
  group_by(day) %>%
  summarise(
    avg_international_case_data = mean(international_case_data, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_international_case_data))

# query using dplyr TODO
# delay_tbl <- flights_tbl %>%
# select(tailnum, distance, arr_delay) %>%
# group_by(tailnum) %>%
# summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
# filter(count > 20L, dist < 2000L, !is.na(delay)) %>%
# arrange(delay, dist, count)

# Display the table
# delay_tbl

# Execute the query and return to R as a dataframe
#delay <- delay_tbl %>% collect()
