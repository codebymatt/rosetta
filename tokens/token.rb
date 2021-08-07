# frozen_string_literal: true

# Holds logic and information for token management.
class Token
  TOP_LEVEL_CLASS_NAMES = [
    :Header, :LineBreak, :Quote, :CodeBlockDelimiter, :BasicListItem, :NumberedListItem, :Link
  ].freeze

  INLINE_TOKEN_TYPES = [:BOLD, :ITALICS, :LINK, :INLINE_CODE, :STRIKETHROUGH, :TEXT].freeze

  def initialize(source_text)
    @source_text = source_text
  end

  def to_s
    "<Token type='#{type}' value='#{value}'>"
  end

  def type
    raise 'Subclass should handle type.'
  end

  def value
    raise 'Subclass should handle value.'
  end

  def inline?
    INLINE_TOKEN_TYPES.include?(type)
  end
end
