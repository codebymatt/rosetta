# frozen_string_literal: true

# Holds logic and information for basic token management.
class BasicToken
  TOP_LEVEL_CLASS_NAMES = [
    :Header, :LineBreak, :Quote, :CodeBlockDelimiter, :BasicListItem, :NumberedListItem, :Link
  ].freeze

  # INLINE_CLASS_NAMES = [:BOLD, :ITALICS, :LINK, :INLINE_CODE, :STRIKETHROUGH, :TEXT].freeze
  INLINE_CLASS_NAMES = [:Bold, :Italics, :Strikethrough, :InlineCode].freeze

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

  def inline?
    INLINE_CLASS_NAMES.include?(type)
  end
end
