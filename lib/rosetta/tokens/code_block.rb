# frozen_string_literal: true

require './lib/rosetta/tokens/block_token'

# Handles logic for Code Block tokens
class CodeBlock < BlockToken
  def type
    :CODE_BLOCK
  end
end
