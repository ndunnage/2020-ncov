# (Required) Install the sparklyr package
# install.packages("sparklyr")

library(stringr)
library(sparklyr)
library(dplyr)

spark <- spark_connect(master = "yarn")
sc = spark

# load data from file in HDFS
international_case_data <- spark_read_csv(
  sc = spark,
  dbtable = "u_ndunnage",
  name = "international_case_data",
  path = "/user/ndunnage/ncov2020/data/international_case_data.csv"
)
# Use personal DB
spark_session(sc) %>% invoke("sql", "USE u_ndunnage")
# Show the tables
db_list_tables(sc)

# Run a Query
tbl(sc, sql("SELECT * FROM international_case_data"))

# OR load data from table
#tbl_change_db(sc, name)
international_case_data <- tbl(sc, "international_case_data")

# query using dplyr
international_case_data %>%
  filter(country %like% "%China%") %>%
  group_by(date) %>%
  summarise(
    avg_db_query_fields = mean(number, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_db_query_fields))


# query using SQL
tbl(spark, sql("
  SELECT date,AVG(number) AS avg_number \
  FROM international_case_data \
  WHERE country LIKE '%China%' \
  GROUP BY date \
  ORDER BY avg_number DESC"))

spark_disconnect(spark)
