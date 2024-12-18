FROM apache/airflow:2.10.3
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER airflow
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" apache-airflow-providers-apache-spark==2.1.3
RUN curl -O https://archive.apache.org/dist/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz && \
    tar -xvf spark-3.5.3-bin-hadoop3.tgz -C /opt && \
    ln -s /opt/spark-3.5.3-bin-hadoop3 /opt/spark && \
    rm spark-3.5.3-bin-hadoop3.tgz

ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH



# # Використовуємо базовий образ з Python
# FROM python:3.12-slim

# # Оновлюємо apt та встановлюємо необхідні пакети
# RUN apt-get update && apt-get install -y \
#     openjdk-17-jdk \
#     procps \
#     curl \
#     gnupg \
#     bash \
#     && rm -rf /var/lib/apt/lists/*

# # Встановлюємо Python бібліотеки, необхідні для PySpark
# RUN pip install --upgrade pip && pip install \
#     pyspark==3.4.0 \
#     apache-airflow[apache2] \
#     pandas

# # Встановлюємо змінні середовища для Java та Spark
# ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
# ENV PATH=$PATH:$JAVA_HOME/bin
# ENV SPARK_HOME=/opt/spark
# ENV PYSPARK_DRIVER_PYTHON=python
# ENV PYSPARK_PYTHON=python

# # Завантажуємо та встановлюємо Spark
# RUN curl -o /tmp/spark.tgz -L "https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz" \
#     && tar -xvzf /tmp/spark.tgz -C /opt \
#     && rm /tmp/spark.tgz

# # Створюємо символічне посилання для Spark
# RUN ln -s /opt/spark-3.5.3-bin-hadoop3 /opt/spark

# # Встановлюємо робочу директорію
# WORKDIR /opt/airflow

# # Копіюємо DAGS
# COPY ./dags /opt/airflow/dags

# # Встановлюємо точку входу для Airflow
# ENTRYPOINT ["bash", "-c", "airflow db init && airflow scheduler & airflow webserver"]

# # Відкриваємо порти
# EXPOSE 8080

# # Замість CMD можна використовувати ENTRYPOINT для запуску webserver:
# CMD ["airflow", "webserver"]
