defmodule ReorderModule.Warehouses.Warehouse do
  use Ecto.Schema
  import Ecto.Changeset


  schema "warehouses" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(warehouse, attrs) do
    warehouse
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
