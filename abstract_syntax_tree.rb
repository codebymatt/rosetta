# frozen_string_literal: true

require './services/tree_parser'

# Holds all logic for creating the AST, including parsing.
class AbstractSyntaxTree
  attr_reader :base_tokens

  def initialize(base_tokens)
    @base_tokens = base_tokens
  end

  def token_tree
    @token_tree ||= TreeParser.call(@base_tokens)
  end

  def formatted_token_tree
    token_tree.map(&:to_s)
  end

  def node_representation
    token_tree.map(&:node_representation)
  end

  def raw_tokens
    @base_tokens.map(&:to_s)
  end
end
