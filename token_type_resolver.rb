# frozen_string_literal: true

require './header'
require './service'

# Resolves token types from source text.
class TokenTypeResolver < Service
  def initialize(text)
    @text = text
  end

  def call
    return :LINE_BREAK if @text == ''

    return :HEADER if Header.header?(@text)

    :PARAGRAPH
  end
end
