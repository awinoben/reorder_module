defmodule ReorderModule.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :quantity, :integer
      add :reorder_level, :integer
      add :description, :string

      timestamps()
    end

  end
end
