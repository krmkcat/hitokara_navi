require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # タイムゾーンを東京に設定
    config.time_zone = 'Tokyo'
    # DB読み書き時のタイムゾーンを実行環境のOSと同じに設定
    config.active_record.default_timezone= :local

    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.action_mailer.default_url_options = Settings.default_url_options.to_h

    config.generators do |g|
      g.helper false # helperを生成しない
      g.test_framework false #testを生成しない
      g.skip_routes true #ルーティングの記述を生成しない
    end
  end
end
