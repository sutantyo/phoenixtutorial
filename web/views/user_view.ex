defmodule App.UserView do
  use App.Web, :view
  def capitalise(name) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
