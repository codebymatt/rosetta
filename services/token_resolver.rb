# frozen_string_literal: true

require './services/service_base'
require './tokens/header'
require './tokens/token'
require './tokens/paragraph'
require './tokens/line_break'

# Resolves token types from source text.
class TokenResolver < ServiceBase
  def initialize(text)
    @text = text
  end

  def call
    top_level_token_classes.each do |type_class|
      return type_class.new(@text) if type_class.matches?(@text)
    end

    Paragrah.new(@text)
  end

  private

  def top_level_token_classes
    Token::TOP_LEVEL_CLASS_NAMES.map { |type| constantize_type(type) }
  end

  def constantize_type(type)
    Object.const_get(type)
  end
end
