defmodule App.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :username, :string, null: false
      add :email, :string, null: false
    	add :password_hash, :string
      add :status, :string, null: false

      timestamps # add timestamps to database entry
    end
    create unique_index(:users, [:username])
  end

end
