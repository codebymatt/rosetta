# frozen_string_literal: true

require './abstract_syntax_tree'
require './scanner'
require './services/html_writer'

# We ignore the issue of large file sizes for now.
# TODO: Optimise file reading, i.e. stream input for large source files.

puts 'Correct usage: ruby main.rb <source_filename>' if ARGV.length != 1

source_filename = ARGV[0]
source_file = File.read(source_filename)

source_tokens = Scanner.new(source_file).tokenise

abstract_syntax_tree = AbstractSyntaxTree.new(source_tokens)

# puts abstract_syntax_tree.node_representation

html_output = HTMLWriter.call(abstract_syntax_tree.token_tree)

puts html_output
