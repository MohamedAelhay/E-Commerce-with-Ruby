# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
 Rails.application.config.assets.precompile += %w( js/vendor/jquery-2.2.4.min.js 
                                                  https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js 
                                                  js/vendor/bootstrap.min.js
                                                  js/jquery.ajaxchimp.min.js 
                                                  js/jquery.nice-select.min.js
                                                js/jquery.sticky.js
                                                js/nouislider.min.js
                                                js/countdown.js
                                                js/jquery.magnific-popup.min.js
                                                js/owl.carousel.min.js
                                                https://maps.googleapis.com/maps/api/js?key=AIzaSyCjCGmQ0Uq4exrzdcL6rvxywDDOvfAu6eE
                                                js/gmaps.min.js
                                                js/main.js)
                                                  