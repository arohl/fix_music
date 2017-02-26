#! /opt/local/bin/ruby

require 'taglib'
require 'trollop'

opts = Trollop::options do
  version "fix_metadata 1.0.0 (c) 2017 Andrew Rohl"
banner <<-EOS
fix_music_metadata is a program for easily changing the metadata of your music.

Usage:
     fix_metadata [options] <filenames>+
where [options] are:
EOS

  opt :strip_leading_brackets, "Removes brackets from song title if first character", :short => 's'
  opt :artist, "Set the artist", :type => :string, :short => 'a'
  opt :title, "Set the title", :type => :string, :short => 't'
  opt :genre, "Set the genre", :type => :string, :short => 'g'
  opt :comment, "Set the comment", :type => :string, :short => 'c'
  opt :year, "Set the year", :type => :int, :short => 'y'
end

puts ""
puts "| Track | Filename | Title | Artist | Album | Year | Genre | Sample Rate | Comment |"
puts "| ----- | -------- |------ | ------ | ----- | ---- | ----- | ----------- | ------- |"

ARGV.each do |filename|
  TagLib::FileRef.open(filename) do |fileref|
    unless fileref.null?
      tag = fileref.tag
      prop = fileref.audio_properties

      if opts[:strip_leading_brackets]
        count = 0
        new_string = ""
        # remove any whitespace
        tmp_title = tag.title.strip
        # does the title start with open bracket?
        if tmp_title[0] == "("
          # if so, iterate over rest of string
          tmp_title[1..-1].each_char do |c|
            copy_c = true
            if c == "("
              count += 1
            elsif c == ")"
              if count == 0
                copy_c = false
              else
                count -= 1
              end
            end
            if copy_c
              new_string << c
            end
          end
          tag.title = new_string
        end
      end

      if opts[:artist_given]
        tag.artist = opts[:artist]
      end

      if opts[:title_given]
        tag.title = opts[:title]
      end

      if opts[:genre_given]
        tag.genre = opts[:genre]
      end

      if opts[:comment]
        tag.comment = opts[:comment]
      end

      if opts[:year_given]
        tag.year = opts[:year]
      end

      fileref.save

      puts "| " + tag.track.to_s + " | " + filename + " | " + tag.title + " | " + tag.artist + " | " + tag.album + " | " + tag.year.to_s + " | " + tag.genre + " | " + prop.sample_rate.to_s + " |" + tag.comment + " | "

    end
  end
end
