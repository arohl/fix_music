#! /opt/local/bin/ruby

require 'taglib'
require 'trollop'

opts = Trollop::options do
  version "fix_metadata 0.0.1 (c) 2017 Andrew Rohl"
banner <<-EOS
fix_music_metadata is a program for easily changing the metadata of your music.

Usage:
     fix_metadata [options] <filenames>+
where [options] are:
EOS

  opt :strip_leading_brackets, "Removes brackets from song title if first character", :short => 's'
  opt :artist, "Set the artist", :type => :string, :short => 'a'
  opt :genre, "Set the genre", :type => :string, :short => 'g'
  opt :year, "Set the year", :type => :int, :short => 'y'
end

p opts

if opts[:strip_leading_brackets]
  puts "stripping"
end

if opts[:year_given]
  year = opts[:year]
  puts "setting year to " + year.to_s
end
puts ""
puts "| Track | Filename | Title | Artist | Album | Year | Genre | Comment |"
puts "| ----- | -------- |------ | ------ | ----- | ---- | ----- | ------- |"

ARGV.each do |filename|
  TagLib::FileRef.open(filename) do |fileref|
    unless fileref.null?
      tag = fileref.tag
      puts "| " + tag.track.to_s + " | " + tag.title + " | " + filename + " | " + tag.artist + " | " + tag.album + " | " + tag.year.to_s + " | " + tag.genre + " | " + tag.comment + " |"

        new_title = tag.title
      # remove any whitespace
      new_title = tag.title.strip

  #    fileref.save
    end
  end
end
