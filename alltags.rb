#! /opt/local/bin/ruby

require 'taglib'

puts "| Track | Filename | Title | Artist | Album | Year | Genre | Comment |"
puts "| ----- | -------- |------ | ------ | ----- | ---- | ----- | ------- |"

ARGV.each do |filename|
  TagLib::FileRef.open(filename) do |fileref|
    unless fileref.null?
      tag = fileref.tag
      puts "| " + tag.track.to_s + " | " + filename + " | " + tag.title + " | " + tag.artist + " | " + tag.album + " | " + tag.year.to_s + " | " + tag.genre + " | " + tag.comment + " |"

        new_title = tag.title
    end
  end
end
