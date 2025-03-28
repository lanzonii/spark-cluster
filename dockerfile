FROM python:3.9-slim

# Instalando o apt
## Instalando o java para o spark
## Instalando o wget para pegar o spark da web
## Instalando o nano para editar arquivos
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openjdk-17-jdk
RUN apt-get install -y wget
RUN apt-get clean
RUN apt-get install -y nano

# Definindo a variável de ambiente do java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Download e instalação do spark
## Variáveis de ambiente
ENV SPARK_VERSION=3.5.5
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark

## Instalando o spark
RUN wget -q https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Variável de ambiente do spark
ENV PATH=$SPARK_HOME/bin:$PATH 

# Instalando o PySpark
RUN pip install pyspark==${SPARK_VERSION}

# Criando o diretório de "área de trabalho!
RUN mkdir -p /opt/workspace

WORKDIR /opt/workspace

# Copiando o script que sempre vai rodar quando o container iniciar
COPY entrypoint.sh /
RUN chmod +x /

ENTRYPOINT [ "/entrypoint.sh" ]