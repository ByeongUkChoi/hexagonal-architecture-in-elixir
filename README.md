# Hexagonal architecture in Elixir

Check our [getting started guide](https://byeongukchoi.github.io/hexagonal-architecture-in-elixir) to begin your journey with Hexagonal architecture.  

---  
###### Start project
```
# create phoenix project
mix phx.new hexagonal-architecture-in-elixir --app blog --no-html --no-assets --no-gettext --no-dashboard --no-live --no-mailer

# postgres docker run
docker pull postgres
docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
