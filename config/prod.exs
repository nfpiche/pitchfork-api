use Mix.Config

config :pitchfork_api, PitchforkApi.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "shrouded-badlands-35511.herokuapp.com", port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :pitchfork_api, PitchforkApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL")
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :logger, level: :info
