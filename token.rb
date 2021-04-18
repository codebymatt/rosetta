# frozen_string_literal: true

require './header'
require './line_break'
require './token_type_resolver'

# Holds logic and information for token management.
class Token
  attr_reader :value

  def initialize(source_text)
    @source_text = source_text
    @base_type = determine_token_type
    @type_handler = instantiate_type_handler
    @value = @type_handler.extract_value_from_text
  end

  def type
    @type_handler.type
  end

  def to_s
    "<Token type='#{type}' value='#{value}'>"
  end

  private

  def determine_token_type
    TokenTypeResolver.call(@source_text)
  end

  def instantiate_type_handler
    base_type_class = constantize_base_type
    base_type_class.new(@source_text)
  end

  def constantize_base_type
    Object.const_get(camel_case_type)
  end

  def camel_case_type
    @base_type.to_s               # 'LINE_BREAK'
              .split('_')         # ['LINE', 'BREAK']
              .map(&:downcase)    # ['line', 'break']
              .map(&:capitalize)  # ['Line', 'Break']
              .join('')           # 'LineBreak'
  end
end
