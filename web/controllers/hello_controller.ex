defmodule App.HelloController do
  use App.Web, :controller
  def world(conn, %{"name" => name}) do
    render conn, "world.html", name: name
  end

  def world(conn, _params) do
    render conn, "world.html", name: "stranger"
  end


end
