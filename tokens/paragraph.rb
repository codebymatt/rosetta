# frozen_string_literal: true

require './tokens/token'

# Handles logic for Paragraph tokens.
class Paragraph < Token
  def type
    :PARAGRAPH
  end

  def value
    @source_text
  end
end
