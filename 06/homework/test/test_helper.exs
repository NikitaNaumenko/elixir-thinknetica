ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Homework.Repo, :manual)
Mox.defmock(Homework.ExchangeRateMockAPI, for: Homework.ExchangeRateAPI)
Application.put_env(:homework, :exchange_rate_api, Homework.ExchangeRateMockAPI)
