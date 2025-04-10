# frozen_string_literal: true

Sentry.init do |config|
  config.environment = "production"
  config.enabled_environments = %w[production]
  config.dsn = "https://78d47b91fe81620315ed7e7b55597421@o4509073159028736.ingest.de.sentry.io/4509073160274000"
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]

  config.send_default_pii = true
end
