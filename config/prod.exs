use Mix.Config

config :pitchfork_api, PitchforkApi.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "https://afternoon-waters-20741.herokuapp.com/", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :logger, level: :info

import_config "prod.secret.exs"
