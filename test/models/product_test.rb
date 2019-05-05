require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save product without brand" do
    product = Product.new(category: @category, store: @store, title: "test title",
                          description: "test description", price: 100, quantity: 3)
    assert_not product.save
  end

  test "should not save product without category" do
    product = Product.new(brand: @brand, store: @store, title: "test title",
                          description: "test description", price: 100, quantity: 3)
    assert_not product.save
  end

  test "should not save product without store" do
    product = Product.new(brand: @brand, category: @category,title: "test title",
                          description: "test description", price: 100, quantity: 3)
    assert_not product.save
  end

  test "should not save product without title" do
    product = Product.new(brand: @brand, category: @category, store: @store,
                          description: "test description", price: 100, quantity: 3)
    assert_not product.save
  end

  test "should not save product without description" do
    product = Product.new(brand: @brand, category: @category, store: @store,
                          title: "test title", price: 100, quantity: 3)
    assert_not product.save
  end

  test "should not save product without price" do
    product = Product.new(brand: @brand, category: @category, store: @store,
                          title: "test title", description: "test description", quantity: 3)

    assert_not product.save
  end

  test "should not save product without quantity" do
    product = Product.new(brand: @brand, category: @category, store: @store,
                          title: "test title", description: "test description", price: 100)
    assert_not product.save
  end

end
