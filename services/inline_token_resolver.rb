# frozen_string_literal: true

require './tokens/text'

# Matches and extracts tokens contained in text.
class InlineTokenResolver < ServiceBase
  def initialize(line)
    @line = line
    @tokens = []
    @current_counter = 0
    @base_counter = 0
  end

  def call
    # TODO: TEST HOW BOLD WORKS WITH THIS
    until end_of_line?
      inline_token_classes.each do |type_class|
        current_line = @line[current_counter]
        @tokens << consume(current_line, type_class) if type_class.matches?(current_line)
      end
    end

    @tokens
  end

  private

  def inline_token_classes
    BasicToken::INLINE_CLASS_NAMES.map { |type| constantize_type(type) }
  end

  # TODO: Can this be done without mutating state?
  def consume(_klass)
    text = @line[@base_counter..@current_counter]
    @tokens << Text.new(text) if text.length.positive?

    @current_counter += length_consumed
    @base_counter = @current_counter

    token
  end

  def constantize_type(type)
    Object.const_get(type)
  end

  def end_of_line?
    @counter >= @line.length - 1
  end
end
