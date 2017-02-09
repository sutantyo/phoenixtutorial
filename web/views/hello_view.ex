defmodule App.HelloView do
  use App.Web, :view
  def capitalise(name) do
    String.capitalize(name)
  end
end
