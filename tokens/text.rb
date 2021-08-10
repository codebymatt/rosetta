# frozen_string_literal: true

require './tokens/basic_token'

# Handles logic for Text tokens.
class Text < BasicToken
  def type
    :TEXT
  end

  def value
    @source_text
  end
end
