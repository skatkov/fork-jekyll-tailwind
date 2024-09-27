# frozen_string_literal: true

require_relative "jekyll-tailwind-cli/version"

require "jekyll"
require "tailwindcss/ruby"

module Jekyll
  class Tailwind
    def self.root
      File.dirname(__dir__)
    end

    def self.compile(debug: false, **kwargs)
      command = [
                Tailwindcss::Ruby.executable(**kwargs),
                "--input", Jekyll::Tailwind.root.join("assets/css/app.css").to_s,
                "--output", Jekyll::Tailwind.root.join("_site/assets/css/app.css").to_s,
                "--config", Jekyll::Tailwind.root.join("tailwind.config.js").to_s,
              ]

      postcss_path = Jekyll::Tailwind.root.join("postcss.config.js")
      command += ["--postcss", postcss_path.to_s] if File.exist?(postcss_path)

      command
    end
  end
end

Jekyll::Hooks.register [:site], :post_write do |site|
  Jekyll::Tailwind.compile
end
