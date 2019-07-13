defmodule ReorderModuleWeb.ReorderControllerTest do
  use ReorderModuleWeb.ConnCase

  alias ReorderModule.Reorders

  @create_attrs %{amount: 42, status: 42}
  @update_attrs %{amount: 43, status: 43}
  @invalid_attrs %{amount: nil, status: nil}

  def fixture(:reorder) do
    {:ok, reorder} = Reorders.create_reorder(@create_attrs)
    reorder
  end

  describe "index" do
    test "lists all reorders", %{conn: conn} do
      conn = get conn, reorder_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Reorders"
    end
  end

  describe "new reorder" do
    test "renders form", %{conn: conn} do
      conn = get conn, reorder_path(conn, :new)
      assert html_response(conn, 200) =~ "New Reorder"
    end
  end

  describe "create reorder" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, reorder_path(conn, :create), reorder: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == reorder_path(conn, :show, id)

      conn = get conn, reorder_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Reorder"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, reorder_path(conn, :create), reorder: @invalid_attrs
      assert html_response(conn, 200) =~ "New Reorder"
    end
  end

  describe "edit reorder" do
    setup [:create_reorder]

    test "renders form for editing chosen reorder", %{conn: conn, reorder: reorder} do
      conn = get conn, reorder_path(conn, :edit, reorder)
      assert html_response(conn, 200) =~ "Edit Reorder"
    end
  end

  describe "update reorder" do
    setup [:create_reorder]

    test "redirects when data is valid", %{conn: conn, reorder: reorder} do
      conn = put conn, reorder_path(conn, :update, reorder), reorder: @update_attrs
      assert redirected_to(conn) == reorder_path(conn, :show, reorder)

      conn = get conn, reorder_path(conn, :show, reorder)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, reorder: reorder} do
      conn = put conn, reorder_path(conn, :update, reorder), reorder: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Reorder"
    end
  end

  describe "delete reorder" do
    setup [:create_reorder]

    test "deletes chosen reorder", %{conn: conn, reorder: reorder} do
      conn = delete conn, reorder_path(conn, :delete, reorder)
      assert redirected_to(conn) == reorder_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, reorder_path(conn, :show, reorder)
      end
    end
  end

  defp create_reorder(_) do
    reorder = fixture(:reorder)
    {:ok, reorder: reorder}
  end
end
