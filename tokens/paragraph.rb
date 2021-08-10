# frozen_string_literal: true

require './tokens/block_token'

# Handles logic for Paragraph tokens
class Paragraph < BlockToken
  def type
    :PARAGRAPH
  end
end
