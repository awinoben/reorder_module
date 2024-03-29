defmodule ReorderModule.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReorderModule.Accounts.User
  # alias Comeonin.Bcrypt


  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password])
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> validate_length(:encrypted_password, min: 5)
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)
  end
end
