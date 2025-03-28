#!/bin/bash

if [ "$SPARK_MODE" = "master" ]; then
    exec /opt/spark/bin/spark-class org.apache.spark.deploy.master.Master
    exec pyspark
else
    exec /opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077
fi