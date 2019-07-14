defmodule ReorderModule.Repo.Migrations.CreateReorders do
  use Ecto.Migration

  def change do
    create table(:reorders) do
      add :amount, :string
      add :status, :string
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:reorders, [:product_id])
  end
end
