# frozen_string_literal: true

require './html_generator'

# Turns a tree of tokens into it's corresponding HTML output.
class HTMLWriter < ServiceBase
  def initialize(token_tree)
    @token_tree = token_tree
  end

  def call
    @token_tree.map { |token| html_generator.generate(token) }.compact.join
  end

  def html_generator
    @html_generator ||= HTMLGenerator.new
  end
end
