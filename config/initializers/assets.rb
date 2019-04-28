# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "images")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( 
    styles/main_styles.css 
    styles/responsive
    plugins/flexslider/flexslider.css
    plugins/OwlCarousel2-2.2.1/owl.carousel.css
    plugins/OwlCarousel2-2.2.1/owl.theme.css
    plugins/OwlCarousel2-2.2.1/owl.theme.default.css
    plugins/OwlCarousel2-2.2.1/animate.css
    plugins/font-awesome-4.7.0/css/font-awesome.min.css
    styles/bootstrap-4.1.2/bootstrap.min.css
    js/jquery-3.2.1.min.js
    styles/bootstrap-4.1.2/popper.js
    styles/bootstrap-4.1.2/bootstrap.min.js
    plugins/greensock/TweenMax.min.js
    plugins/greensock/TimelineMax.min.js
    plugins/scrollmagic/ScrollMagic.min.js
    plugins/greensock/animation.gsap.min.js
    plugins/greensock/ScrollToPlugin.min.js
    plugins/OwlCarousel2-2.2.1/owl.carousel.js
    plugins/easing/easing.js
    plugins/progressbar/progressbar.min.js
    plugins/parallax-js-master/parallax.min.js
    js/custom.js
    plugins/flexslider/jquery.flexslider-min.js
    )

