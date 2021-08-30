# frozen_string_literal: true

require './lib/rosetta/abstract_syntax_tree'
require './lib/rosetta/formatters/html/html_writer'
require './lib/rosetta/services/input_scanner'

# We ignore the issue of large file sizes for now.
# TODO: Optimise file reading, i.e. stream input for large source files.

puts 'Correct usage: ruby main.rb <source_filename>' if ARGV.length != 1

source_filename = ARGV[0]
source_file = File.read(source_filename)

source_tokens = InputScanner.call(source_file)

abstract_syntax_tree = AbstractSyntaxTree.new(source_tokens)

html_output = HTMLWriter.call(abstract_syntax_tree.token_tree)

puts html_output
