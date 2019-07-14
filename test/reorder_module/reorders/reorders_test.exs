defmodule ReorderModule.ReordersTest do
  use ReorderModule.DataCase

  alias ReorderModule.Reorders

  describe "reorders" do
    alias ReorderModule.Reorders.Reorder

    @valid_attrs %{amount: 42, status: 42}
    @update_attrs %{amount: 43, status: 43}
    @invalid_attrs %{amount: nil, status: nil}

    def reorder_fixture(attrs \\ %{}) do
      {:ok, reorder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reorders.create_reorder()

      reorder
    end

    test "list_reorders/0 returns all reorders" do
      reorder = reorder_fixture()
      assert Reorders.list_reorders() == [reorder]
    end

    test "get_reorder!/1 returns the reorder with given id" do
      reorder = reorder_fixture()
      assert Reorders.get_reorder!(reorder.id) == reorder
    end

    test "create_reorder/1 with valid data creates a reorder" do
      assert {:ok, %Reorder{} = reorder} = Reorders.create_reorder(@valid_attrs)
      assert reorder.amount == 42
      assert reorder.status == 42
    end

    test "create_reorder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reorders.create_reorder(@invalid_attrs)
    end

    test "update_reorder/2 with valid data updates the reorder" do
      reorder = reorder_fixture()
      assert {:ok, reorder} = Reorders.update_reorder(reorder, @update_attrs)
      assert %Reorder{} = reorder
      assert reorder.amount == 43
      assert reorder.status == 43
    end

    test "update_reorder/2 with invalid data returns error changeset" do
      reorder = reorder_fixture()
      assert {:error, %Ecto.Changeset{}} = Reorders.update_reorder(reorder, @invalid_attrs)
      assert reorder == Reorders.get_reorder!(reorder.id)
    end

    test "delete_reorder/1 deletes the reorder" do
      reorder = reorder_fixture()
      assert {:ok, %Reorder{}} = Reorders.delete_reorder(reorder)
      assert_raise Ecto.NoResultsError, fn -> Reorders.get_reorder!(reorder.id) end
    end

    test "change_reorder/1 returns a reorder changeset" do
      reorder = reorder_fixture()
      assert %Ecto.Changeset{} = Reorders.change_reorder(reorder)
    end
  end

  describe "reorders" do
    alias ReorderModule.Reorders.Reorder

    @valid_attrs %{amount: "some amount", status: "some status"}
    @update_attrs %{amount: "some updated amount", status: "some updated status"}
    @invalid_attrs %{amount: nil, status: nil}

    def reorder_fixture(attrs \\ %{}) do
      {:ok, reorder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reorders.create_reorder()

      reorder
    end

    test "list_reorders/0 returns all reorders" do
      reorder = reorder_fixture()
      assert Reorders.list_reorders() == [reorder]
    end

    test "get_reorder!/1 returns the reorder with given id" do
      reorder = reorder_fixture()
      assert Reorders.get_reorder!(reorder.id) == reorder
    end

    test "create_reorder/1 with valid data creates a reorder" do
      assert {:ok, %Reorder{} = reorder} = Reorders.create_reorder(@valid_attrs)
      assert reorder.amount == "some amount"
      assert reorder.status == "some status"
    end

    test "create_reorder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reorders.create_reorder(@invalid_attrs)
    end

    test "update_reorder/2 with valid data updates the reorder" do
      reorder = reorder_fixture()
      assert {:ok, reorder} = Reorders.update_reorder(reorder, @update_attrs)
      assert %Reorder{} = reorder
      assert reorder.amount == "some updated amount"
      assert reorder.status == "some updated status"
    end

    test "update_reorder/2 with invalid data returns error changeset" do
      reorder = reorder_fixture()
      assert {:error, %Ecto.Changeset{}} = Reorders.update_reorder(reorder, @invalid_attrs)
      assert reorder == Reorders.get_reorder!(reorder.id)
    end

    test "delete_reorder/1 deletes the reorder" do
      reorder = reorder_fixture()
      assert {:ok, %Reorder{}} = Reorders.delete_reorder(reorder)
      assert_raise Ecto.NoResultsError, fn -> Reorders.get_reorder!(reorder.id) end
    end

    test "change_reorder/1 returns a reorder changeset" do
      reorder = reorder_fixture()
      assert %Ecto.Changeset{} = Reorders.change_reorder(reorder)
    end
  end
end
