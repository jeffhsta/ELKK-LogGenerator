use Mix.Config

config :kafka_ex,
  brokers: [
    {"127.0.0.1", 9092},
  ],
  consumer_group: "fakelc",
  disable_default_worker: false,
  sync_timeout: 3000,
  max_restarts: 10,
  max_seconds: 60,
  use_ssl: false,
  kafka_version: "0.9.0",
  topic: "logging"
