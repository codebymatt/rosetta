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

  def node_representation
    opening_tag = "<#{type} child_count=#{children.count}>"
    closing_tag = "<#{type} />"

    contents = children.map { |token| "  #{token.node_representation}" }.join("\n")

    # puts contents

    "#{opening_tag}\n#{contents}\n#{closing_tag}"
  end

  def type
    raise 'Subclass should handle #type.'
  end

  def value
    raise 'Subclass should handle #value.'
  end
end
