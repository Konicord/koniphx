# Koniphx

A small playground for myself to "play" around with [Phoenix](http://www.phoenixframework.org/) and [TailwindCSS](https://tailwindcss.com/).

---

### Adding a new page

1. Create a route for it (`lib/koniphx_web/router.ex`)

```elixir
 scope "/", KoniphxWeb do
    pipe_through :browser

    get "/newpage", NewPageController, :index
  end
```

We also specified a controller, so lets create that.

2. Create a controller (`lib/koniphx_web/controllers/new_page_controller.ex`)

```elixir
defmodule KoniphxWeb.NewPageController do
  use KoniphxWeb, :controller

  def index(conn, _params) do
    render(conn, "newpage.html")
  end
end
```

3. Create a view (`lib/koniphx_web/views/new_page_view.ex`)

```elixir
defmodule KoniphxWeb.NewPageView do
  use KoniphxWeb, :view
end
```

4. Create a template (`lib/koniphx_web/templates/new_page/newpage.html.eex`)

```html
<h1>Welcome to New Page!</h1>
```

Remember, you first have to create a directory for the template to live in :)

---

### Call a custom controller

If you want to send data to your controller, you can do it like this:

```html
<form
  method="post"
  action="/route_here"
  id="some_id"
  class="mx-auto max-w-sm flex flex-col items-center justify-center h-screen"
>
  <input
    type="hidden"
    name="_csrf_token"
    value="{Plug.CSRFProtection.get_csrf_token}"
  />
  <div class="mb-4">
    <label class="block text-gray-700 text-sm font-bold mb-2" for="name">
      Name
    </label>
    <input
      class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
      id="name"
      name="name"
      type="text"
      placeholder="Name"
    />
  </div>
  <div class="flex items-center justify-between">
    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
      type="submit"
    >
      Submit
    </button>
  </div>
</form>
```

This will send a `POST` request to the route `/route_here` with the data `name` and `_csrf_token` (which is needed for security reasons).

Make sure to add the `post` method in the router

```elixir
post "/route_here", ARouteController, :request_function
```

and then use the provided `request_function` in the controller

```elixir
def request_function(conn, params) do
  if conn.params["name"] == "something" do
  # do something
  else
  # do something else
end
```

You could use `phx-click` in [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) to send / handle data requests (generally easier than the above) because of server-rendered HTML..

---

#### Designing with TailwindCSS

If you want to add Tailwind too, follow the steps:

1.) Add to your mix.exs file

```elixir
defp deps do
  [
    {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
  ]
end
````

2.) Run `mix deps.get`
This will install the new package

3.) Run `mix tailwind.install`

4.) Add tailwind to `config/config.exs`

```elixir
config :tailwind,
  version: "3.0.24",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
```

5.) Add tailwind to the watcher (`config/dev.exs`)

```elixir
  tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
```

6.) Create a `tailwind.config.js` file in the `assets` directory

```javascript
module.exports = {
  mode: "jit",
  content: ["./js/**/*.js", "../lib/*_web/**/*.*ex"],
  plugins: [require("@tailwindcss/typography")],
};
```

7.) Add the following to your `app.css` file

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

and delete `phoenix.css` and all the other stuff from app.css

8.) Start coding!

```html
<div
  class="mx-auto max-w-sm flex flex-col items-center justify-center h-screen"
>
  <div class="text-center">
    <h1>Welcome, centered text!</h1>
  </div>
</div>
```
