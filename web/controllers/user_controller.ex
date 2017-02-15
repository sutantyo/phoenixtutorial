defmodule App.UserController do
  require Logger
  import App.Auth
  use App.Web, :controller

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    users = App.Repo.all(App.User)
    render conn, "index.html", users: users
  end #index

  def show(conn, %{"id" => id}) do
    user = App.Repo.get(App.User, id)
    render conn, "show.html", user: user
  end #show

  def new(conn, _params) do
    changeset = App.User.changeset(%App.User{})
    render conn, "new.html", changeset: changeset
  end #new

  def create(conn, %{"user" => user_params}) do
    changeset = App.User.registration_changeset(%App.User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> App.Auth.login(user)
        |> put_flash(:info, "#{user.name} created")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end #create

  def delete(conn, %{"id" => id}) do
    user = App.Repo.get!(App.User, id)
    App.Repo.delete!(user)
    conn
    |> put_flash(:info, "User #{user.name} deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

end
