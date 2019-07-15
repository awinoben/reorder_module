defmodule ReorderModuleWeb.WarehouseControllerTest do
  use ReorderModuleWeb.ConnCase

  alias ReorderModule.Warehouses

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:warehouse) do
    {:ok, warehouse} = Warehouses.create_warehouse(@create_attrs)
    warehouse
  end

  describe "index" do
    test "lists all warehouses", %{conn: conn} do
      conn = get conn, warehouse_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Warehouses"
    end
  end

  describe "new warehouse" do
    test "renders form", %{conn: conn} do
      conn = get conn, warehouse_path(conn, :new)
      assert html_response(conn, 200) =~ "New Warehouse"
    end
  end

  describe "create warehouse" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, warehouse_path(conn, :create), warehouse: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == warehouse_path(conn, :show, id)

      conn = get conn, warehouse_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Warehouse"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, warehouse_path(conn, :create), warehouse: @invalid_attrs
      assert html_response(conn, 200) =~ "New Warehouse"
    end
  end

  describe "edit warehouse" do
    setup [:create_warehouse]

    test "renders form for editing chosen warehouse", %{conn: conn, warehouse: warehouse} do
      conn = get conn, warehouse_path(conn, :edit, warehouse)
      assert html_response(conn, 200) =~ "Edit Warehouse"
    end
  end

  describe "update warehouse" do
    setup [:create_warehouse]

    test "redirects when data is valid", %{conn: conn, warehouse: warehouse} do
      conn = put conn, warehouse_path(conn, :update, warehouse), warehouse: @update_attrs
      assert redirected_to(conn) == warehouse_path(conn, :show, warehouse)

      conn = get conn, warehouse_path(conn, :show, warehouse)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, warehouse: warehouse} do
      conn = put conn, warehouse_path(conn, :update, warehouse), warehouse: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Warehouse"
    end
  end

  describe "delete warehouse" do
    setup [:create_warehouse]

    test "deletes chosen warehouse", %{conn: conn, warehouse: warehouse} do
      conn = delete conn, warehouse_path(conn, :delete, warehouse)
      assert redirected_to(conn) == warehouse_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, warehouse_path(conn, :show, warehouse)
      end
    end
  end

  defp create_warehouse(_) do
    warehouse = fixture(:warehouse)
    {:ok, warehouse: warehouse}
  end
end
