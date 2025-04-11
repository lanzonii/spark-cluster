from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("ClusterProcessing").master("spark://172.21.0.2:7077").getOrCreate()
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

df = spark.read.csv("./dados_large.csv", header=True, inferSchema=True)

df_filtered = df.filter(df["compras"] > 10)
df_filtered.show()

df_total = df.groupBy("cidade").sum("valor_total")
df_total.show()