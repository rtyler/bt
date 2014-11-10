#!/usr/bin/env ruby

$CLASSPATH << '/usr/local/share/java/classes/swt.jar'

require 'java'
require 'yaml'

require 'rubygems'
require 'colorize'
require 'flickr'


puts 'Starting bt'.green

config =  YAML.load(File.open('.flickr.yml').read)
puts "Using Flickr API configuration: #{config}".yellow

