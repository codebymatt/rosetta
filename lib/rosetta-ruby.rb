# frozen_string_literal: true

require './lib/rosetta/abstract_syntax_tree'
require './lib/rosetta/formatters/html/html_writer'
require './lib/rosetta/services/input_scanner'

# Entry point for the rosetta-ruby gem.
class Rosetta
  def self.markdown_to_html(markdown_source)
    source_tokens = InputScanner.call(markdown_source)
    abstract_syntax_tree = AbstractSyntaxTree.new(source_tokens)

    HTMLWriter.call(abstract_syntax_tree.token_tree)
  end
end
