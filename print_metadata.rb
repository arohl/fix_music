#! /opt/local/bin/ruby

require 'taglib'

puts ""
puts "| Track | Filename | Title | Artist | Album | Year | Genre | Sample Rate | Comment |"
puts "| ----- | -------- |------ | ------ | ----- | ---- | ----- | ----------- | ------- |"

ARGV.each do |filename|
  TagLib::FileRef.open(filename) do |fileref|
    unless fileref.null?
      tag = fileref.tag
      prop = fileref.audio_properties
      puts "| " + tag.track.to_s + " | " + filename + " | " + tag.title + " | " + tag.artist + " | " + tag.album + " | " + tag.year.to_s + " | " + tag.genre + " | " + prop.sample_rate.to_s + " |" + tag.comment + " | "
    end
  end
end
