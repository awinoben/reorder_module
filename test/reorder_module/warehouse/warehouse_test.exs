defmodule ReorderModule.WarehouseTest do
  use ReorderModule.DataCase

  alias ReorderModule.Warehouse

  describe "warehouses" do
    alias ReorderModule.Warehouse.Warehouses

    @valid_attrs %{amount: 42, status: 42}
    @update_attrs %{amount: 43, status: 43}
    @invalid_attrs %{amount: nil, status: nil}

    def warehouses_fixture(attrs \\ %{}) do
      {:ok, warehouses} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Warehouse.create_warehouses()

      warehouses
    end

    test "list_warehouses/0 returns all warehouses" do
      warehouses = warehouses_fixture()
      assert Warehouse.list_warehouses() == [warehouses]
    end

    test "get_warehouses!/1 returns the warehouses with given id" do
      warehouses = warehouses_fixture()
      assert Warehouse.get_warehouses!(warehouses.id) == warehouses
    end

    test "create_warehouses/1 with valid data creates a warehouses" do
      assert {:ok, %Warehouses{} = warehouses} = Warehouse.create_warehouses(@valid_attrs)
      assert warehouses.amount == 42
      assert warehouses.status == 42
    end

    test "create_warehouses/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouses(@invalid_attrs)
    end

    test "update_warehouses/2 with valid data updates the warehouses" do
      warehouses = warehouses_fixture()
      assert {:ok, warehouses} = Warehouse.update_warehouses(warehouses, @update_attrs)
      assert %Warehouses{} = warehouses
      assert warehouses.amount == 43
      assert warehouses.status == 43
    end

    test "update_warehouses/2 with invalid data returns error changeset" do
      warehouses = warehouses_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouses(warehouses, @invalid_attrs)
      assert warehouses == Warehouse.get_warehouses!(warehouses.id)
    end

    test "delete_warehouses/1 deletes the warehouses" do
      warehouses = warehouses_fixture()
      assert {:ok, %Warehouses{}} = Warehouse.delete_warehouses(warehouses)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouses!(warehouses.id) end
    end

    test "change_warehouses/1 returns a warehouses changeset" do
      warehouses = warehouses_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouses(warehouses)
    end
  end
end
