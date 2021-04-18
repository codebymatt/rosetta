# frozen_string_literal: true

require './abstract_syntax_tree'
require './scanner'

# We ignore the issue of large file sizes for now.
# TODO: Optimise file reading, i.e. stream input for large source files.

puts 'Correct usage: ruby main.rb <source_filename>' if ARGV.length != 1

source_filename = ARGV[0]
source_file = File.read(source_filename)

source_tokens = Scanner.new(source_file).tokenise

abstract_syntax_tree = AbstractSyntaxTree.new(source_tokens)
puts abstract_syntax_tree.formatted_representation
