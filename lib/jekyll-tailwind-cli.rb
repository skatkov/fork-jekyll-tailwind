# frozen_string_literal: true

require_relative "jekyll-tailwind-cli/version"

require "jekyll"
require "tailwindcss/ruby"

module Jekyll
  class Tailwind
    def self.root
      @root ||= Pathname.new(File.expand_path('..', __dir__))
    end

    def self.compile
      command = [
                Tailwindcss::Ruby.executable,
                "--input", "assets/css/app.css",
                "--output", "_site/assets/css/app.css",
                "--config", "tailwind.config.js",
              ]

      postcss_path = "postcss.config.js"
      command += ["--postcss", postcss_path] if File.exist?(postcss_path)

      `#{command.join(' ')}`
    end
  end
end

Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind.compile
end
