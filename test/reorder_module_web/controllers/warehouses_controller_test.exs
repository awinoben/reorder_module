defmodule ReorderModuleWeb.WarehousesControllerTest do
  use ReorderModuleWeb.ConnCase

  alias ReorderModule.Warehouse

  @create_attrs %{amount: 42, status: 42}
  @update_attrs %{amount: 43, status: 43}
  @invalid_attrs %{amount: nil, status: nil}

  def fixture(:warehouses) do
    {:ok, warehouses} = Warehouse.create_warehouses(@create_attrs)
    warehouses
  end

  describe "index" do
    test "lists all warehouses", %{conn: conn} do
      conn = get conn, warehouses_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Warehouses"
    end
  end

  describe "new warehouses" do
    test "renders form", %{conn: conn} do
      conn = get conn, warehouses_path(conn, :new)
      assert html_response(conn, 200) =~ "New Warehouses"
    end
  end

  describe "create warehouses" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, warehouses_path(conn, :create), warehouses: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == warehouses_path(conn, :show, id)

      conn = get conn, warehouses_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Warehouses"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, warehouses_path(conn, :create), warehouses: @invalid_attrs
      assert html_response(conn, 200) =~ "New Warehouses"
    end
  end

  describe "edit warehouses" do
    setup [:create_warehouses]

    test "renders form for editing chosen warehouses", %{conn: conn, warehouses: warehouses} do
      conn = get conn, warehouses_path(conn, :edit, warehouses)
      assert html_response(conn, 200) =~ "Edit Warehouses"
    end
  end

  describe "update warehouses" do
    setup [:create_warehouses]

    test "redirects when data is valid", %{conn: conn, warehouses: warehouses} do
      conn = put conn, warehouses_path(conn, :update, warehouses), warehouses: @update_attrs
      assert redirected_to(conn) == warehouses_path(conn, :show, warehouses)

      conn = get conn, warehouses_path(conn, :show, warehouses)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, warehouses: warehouses} do
      conn = put conn, warehouses_path(conn, :update, warehouses), warehouses: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Warehouses"
    end
  end

  describe "delete warehouses" do
    setup [:create_warehouses]

    test "deletes chosen warehouses", %{conn: conn, warehouses: warehouses} do
      conn = delete conn, warehouses_path(conn, :delete, warehouses)
      assert redirected_to(conn) == warehouses_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, warehouses_path(conn, :show, warehouses)
      end
    end
  end

  defp create_warehouses(_) do
    warehouses = fixture(:warehouses)
    {:ok, warehouses: warehouses}
  end
end
