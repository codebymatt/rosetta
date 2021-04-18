# frozen_string_literal: true

# Holds all logic for creating the AST, including parsing.
class AbstractSyntaxTree
  attr_reader :tokens

  def initialize(tokens)
    @tokens = tokens
    parse_tokens
  end

  def parse_tokens; end

  def formatted_representation
    @tokens.map(&:to_s)
  end
end
