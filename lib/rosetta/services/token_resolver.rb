# frozen_string_literal: true

require './lib/rosetta/service_base'
require './lib/rosetta/services/inline_token_resolver'
require './lib/rosetta/tokens/basic_list_item'
require './lib/rosetta/tokens/code_block_delimiter'
require './lib/rosetta/tokens/header'
require './lib/rosetta/tokens/line_break'
require './lib/rosetta/tokens/link'
require './lib/rosetta/tokens/numbered_list_item'
require './lib/rosetta/tokens/quote'
require './lib/rosetta/tokens/text'
require './lib/rosetta/tokens/basic_token'

# Resolves token types from source text.
class TokenResolver < ServiceBase
  def initialize(text)
    @text = text
  end

  def call
    top_level_token_classes.each do |type_class|
      return type_class.new(@text) if type_class.matches?(@text)
    end

    resolve_text_block
  end

  private

  def top_level_token_classes
    BasicToken::TOP_LEVEL_CLASS_NAMES.map { |type| constantize_type(type) }
  end

  def resolve_text_block
    InlineTokenResolver.call(@text)
  end

  def constantize_type(type)
    Object.const_get(type)
  end
end
