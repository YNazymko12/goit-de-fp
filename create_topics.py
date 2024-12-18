from kafka.admin import KafkaAdminClient, NewTopic
from configs import kafka_config

# Створення клієнта Kafka
admin_client = KafkaAdminClient(
    bootstrap_servers=kafka_config['bootstrap_servers'],
    security_protocol=kafka_config['security_protocol'],
    sasl_mechanism=kafka_config['sasl_mechanism'],
    sasl_plain_username=kafka_config['username'],
    sasl_plain_password=kafka_config['password']
)

# Визначення нових топіків
my_name = "yuliia_nazymko"
athlete_event_results_name = f'{my_name}_athlete_event_results'
athlete_avg_stats_name = f'{my_name}_athlete_avg_stats'
num_partitions = 2
replication_factor = 1

# Створення об'єктів NewTopic
athlete_event_results = NewTopic(name=athlete_event_results_name, num_partitions=num_partitions, replication_factor=replication_factor)
athlete_avg_stats = NewTopic(name=athlete_avg_stats_name, num_partitions=num_partitions, replication_factor=replication_factor)

# Видалення старих топіків
try:
    admin_client.delete_topics(topics=[athlete_event_results_name, athlete_avg_stats_name])
    print("Топіки успішно видалено.")
except Exception as e:
    print(f"Помилка при видаленні топіків: {e}")

# Створення нових топіків
try:
    admin_client.create_topics(new_topics=[athlete_event_results, athlete_avg_stats], validate_only=False)
    print(f"Топік '{athlete_event_results_name}' створено успішно.")
    print(f"Топік '{athlete_avg_stats_name}' створено успішно.")
except Exception as e:
    print(f"Виникла помилка під час створення топіків: {e}")

# Закриття зв'язку з клієнтом
admin_client.close()
