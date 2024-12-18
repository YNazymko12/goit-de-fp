kafka_config = {
    "bootstrap_servers": "77.81.230.104:9092",  # IP:порт Kafka-брокера
    "username": "admin",  # Ім'я користувача для аутентифікації
    "password": "VawEzo1ikLtrA8Ug8THa",  # Пароль для аутентифікації
    "security_protocol": "SASL_PLAINTEXT",  # Протокол безпеки
    "sasl_mechanism": "PLAIN",  # Механізм автентифікації
    "sasl_jaas_config": (  # Конфігурація JAAS
        "org.apache.kafka.common.security.plain.PlainLoginModule required "
        'username="admin" password="VawEzo1ikLtrA8Ug8THa";'
    ),
}
