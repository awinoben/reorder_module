defmodule ReorderModule.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :product_id, :integer
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:product_id, :status])
    |> validate_required([:product_id, :status])
  end
end
