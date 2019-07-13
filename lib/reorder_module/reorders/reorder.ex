defmodule ReorderModule.Reorders.Reorder do
  use Ecto.Schema
  import Ecto.Changeset


  schema "reorders" do
    field :amount, :integer
    field :status, :integer
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(reorder, attrs) do
    reorder
    |> cast(attrs, [:amount, :status])
    |> validate_required([:amount, :status])
  end
end
