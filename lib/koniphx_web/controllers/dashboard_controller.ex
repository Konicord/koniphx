defmodule KoniphxWeb.DashboardController do
  use KoniphxWeb, :controller

  def index(conn, _params) do
    render(conn, "dashboard.html")
  end

  def create(conn, %{"name" => name}) do
    render(conn, "dashboard.html", name: name)
  end
end
