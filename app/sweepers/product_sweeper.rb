class ProductSweeper  < ActionController::Cashing::ProductSweeper
    observe Product

    def sweeper(product)
        expire_page product_path(@product)  
    end

    alias_method :after_update, :sweep
end
