# frozen_string_literal: true

require './tokens/token'

# Handles logic for Text tokens.
class Text < Token
  def type
    :TEXT
  end

  def value
    @source_text
  end
end
