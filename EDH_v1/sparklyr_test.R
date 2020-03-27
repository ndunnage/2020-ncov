# (Required) Install the sparklyr package
# install.packages("sparklyr")

library(stringr)
library(sparklyr)
library(dplyr)

spark <- spark_connect(master = "yarn")

# load data from file in HDFS
international_case_data <- spark_read_csv(
  sc = spark,
  name = "international_case_data",
  path = "/user/ndunnage/ncov2020/data/"
)

# OR load data from table
tips <- tbl(spark, "tips")

# query using dplyr
international_case_data %>%
  filter(country %like% "%China%") %>%
  group_by(day) %>%
  summarise(
    avg_international_case_data = mean(international_case_data, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_tip))


# query using SQL
tbl(spark, sql("
  SELECT day,AVG(international_case_data) AS avg_international_case_data \
  FROM international_case_data \
  WHERE country LIKE '%China%' \
  GROUP BY day \
  ORDER BY avg_international_case_data DESC"))

spark_disconnect(spark)
