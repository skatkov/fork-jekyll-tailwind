# frozen_string_literal: true

require_relative "jekyll-tailwind/version"
require_relative "jekyll-tailwind/installer"

require "jekyll"

def tailwind(site)
  Jekyll::Tailwind::Installer.new(
    version: site.config.dig("tailwind", "version"),
    config_path: site.config.dig("tailwind", "config_path")
  )
end

Jekyll::Hooks.register [:site], :post_read do |site|
  tailwind(site).check_install
end

Jekyll::Hooks.register [:site], :pre_render do |site|
  tailwind(site).build
end
