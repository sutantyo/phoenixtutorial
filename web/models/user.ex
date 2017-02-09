defmodule App.User do
  use App.Web, :model # uses web/web.ex
  require Logger

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true # virtuals are not persisted in db
    field :password_hash, :string
    field :status, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username name email status), [])
    # validation
    |> validate_length(:name, min: 1, max: 20)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    Logger.info "in pass_hash"
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> Logger.info inspect(changeset)
           Logger.info "hello"; changeset
    end
  end
end
