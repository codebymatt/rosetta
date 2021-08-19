# frozen_string_literal: true

require './tokens/text'
require './tokens/bold'
require './tokens/italics'
require './tokens/strikethrough'
require './tokens/inline_code'
require 'byebug'

# Matches and extracts tokens contained in text.
class InlineTokenResolver < ServiceBase
  def initialize(line)
    @line = line
    @tokens = []
    @current_counter = 0
    @base_counter = 0
  end

  def call
    until end_of_line?
      matching_token_type = match_token_type

      if matching_token_type.nil?
        @current_counter += 1
      else
        handle_matching_token(matching_token_type)
      end
    end

    consume_plain_text_up_to(@current_counter)
    # @tokens.last.source_text = "#{@tokens.last.source_text}\n" if @tokens.last.inline?
    @tokens << NewLine.new
    @tokens
  end

  private

  def end_of_line?
    @current_counter >= @line.length - 1
  end

  def match_token_type
    current_line = @line[@current_counter..]

    inline_token_classes.find do |token_type|
      token_type.matches?(current_line)
    end
  end

  def handle_matching_token(token_type)
    # We don't want to consume the token type delimiter.
    consume_plain_text_up_to(@current_counter - 1) unless @current_counter.zero?
    @tokens << consume(token_type)
  end

  def consume_plain_text_up_to(final_index)
    plain_text = @line[@base_counter..final_index]
    @base_counter = @current_counter
    @tokens << Text.new(plain_text) unless plain_text.length.zero?
  end

  def inline_token_classes
    @inline_token_classes ||= BasicToken::INLINE_CLASS_NAMES.map { |type| constantize_type(type) }
  end

  def consume(token_type)
    token = token_type.consume(@line[@base_counter..])
    length_consumed = token.source_text.length

    @current_counter += length_consumed
    @base_counter = @current_counter

    token
  end

  def constantize_type(type)
    Object.const_get(type)
  end
end
