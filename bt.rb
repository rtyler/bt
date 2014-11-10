#!/usr/bin/env ruby

# XXX: Local hack to pick up the proper SWT classes on FreeBSD
$CLASSPATH << '/usr/local/share/java/classes/swt.jar'

require 'java'
require 'yaml'

require 'rubygems'
require 'colorize'
require 'flickr'

puts 'Starting bt'.green

config =  YAML.load(File.open('.flickr.yml').read)
#puts "Using Flickr API configuration: #{config}".yellow

require_relative 'bt/main'

puts '..ending bt'.green

BT::Main.new.run
