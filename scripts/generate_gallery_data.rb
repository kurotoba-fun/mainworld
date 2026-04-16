#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
GALLERY_ROOT = File.join(ROOT, "assets", "images", "gallery")
OUTPUT_PATH = File.join(ROOT, "_data", "gallery_items.yml")
GALLERY_TITLES = {
  "amagi" => "天城",
  "arata" => "灼",
  "kairi" => "浬",
  "kujo" => "九条",
  "kuro-shirabe" => "黒調",
  "mairu" => "哩",
  "shirabe" => "調",
  "shirose" => "白瀬",
  "susugaya" => "煤ヶ谷",
  "tachibana" => "橘"
}.freeze
TIMEZONE_OFFSET = "+09:00".freeze

items = GALLERY_TITLES.flat_map do |directory, title|
  source_dir = File.join(GALLERY_ROOT, directory)
  next [] unless Dir.exist?(source_dir)

  Dir.children(source_dir).each_with_object([]) do |filename, gallery_items|
    source_path = File.join(source_dir, filename)
    next unless File.file?(source_path)
    next if filename.start_with?(".")

    gallery_items << {
      "src" => "/assets/images/gallery/#{directory}/#{filename}",
      "title" => title,
      "tags" => [title],
      "date" => File.mtime(source_path).getlocal(TIMEZONE_OFFSET).strftime("%Y-%m-%dT%H:%M:%S%:z"),
      "mtime" => File.mtime(source_path).to_i
    }
  end
end

items.sort_by! { |item| [-item["mtime"], item["src"]] }
items.each { |item| item.delete("mtime") }

File.write(OUTPUT_PATH, items.to_yaml(line_width: -1))
puts "Wrote #{items.size} gallery items to #{OUTPUT_PATH}"
