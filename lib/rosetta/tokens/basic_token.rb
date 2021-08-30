# frozen_string_literal: true

require 'byebug'

# Holds logic and information for basic token management.
class BasicToken
  TOP_LEVEL_CLASS_NAMES = [
    :Header, :LineBreak, :Quote, :CodeBlockDelimiter, :BasicListItem, :NumberedListItem, :Link
  ].freeze

  INLINE_CLASS_NAMES = [:Bold, :Italics, :Strikethrough, :InlineCode, :Link].freeze

  attr_reader :source_text

  def initialize(source_text)
    @source_text = source_text
  end

  def to_s
    "<Token type='#{type}' value='#{value}'>"
  end

  def node_representation
    "<#{type} value='#{value}'>"
  end

  def type
    raise 'Subclass should handle type.'
  end

  def value
    raise 'Subclass should handle value.'
  end

  def accept(visitor)
    method_name = "generate_#{type.to_s.downcase}"
    visitor.send(method_name.to_sym, self)
  end

  # TODO: Make references to token type constant everywhere
  def inline?
    INLINE_CLASS_NAMES.include?(camel_case_type) || type == :TEXT
  end

  private

  def camel_case_type
    # Example: :INLINE_CODE -> :InlineCode
    type.to_s.downcase.split('_').map(&:downcase).map(&:capitalize).join.to_sym
  end
end
