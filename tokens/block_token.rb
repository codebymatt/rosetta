# frozen_string_literal: true

# Holds logic and information for block token management.
class BlockToken
  attr_reader :children

  def initialize(tokens)
    @children = tokens
  end

  def to_s
    "<Token type='#{type}' child_count='#{children.count}' children='#{children}'>"
  end

  def type
    raise 'Subclass should handle #type.'
  end

  def value
    raise 'Subclass should handle #value.'
  end
end
