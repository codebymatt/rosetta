# frozen_string_literal: true

require './services/service_base'
require './tokens/basic_list_item'
require './tokens/code_block_delimiter'
require './tokens/code_block'
require './tokens/header'
require './tokens/break'
require './tokens/line_break'
require './tokens/link'
require './tokens/numbered_list_item'
require './tokens/paragraph'
require './tokens/block_quote'
require './tokens/quote'
require './tokens/text'
require './tokens/basic_token'
require './tokens/basic_list'
require './tokens/numbered_list'
require './tokens/block_token'
require './tokens/new_line'

# Resolves token types from source text.
class TreeParser < ServiceBase
  BLOCK_TOKEN_TYPES = {
    QUOTE: BlockQuote,
    BASIC_LIST_ITEM: BasicList,
    NUMBERED_LIST_ITEM: NumberedList
  }.freeze

  def initialize(tokens)
    @tokens = tokens
    @counter = 0
  end

  # TODO: Investigate if this can be done without declaring and mutating the array.
  def call
    parsed_tree = []
    parsed_tree << consume_next_block until end_of_file?

    parsed_tree.compact
  end

  private

  def consume_next_block
    # TODO: Remove extraneous new lines between paragraphs. Only care about them in paragraphs.

    block_types = BLOCK_TOKEN_TYPES.keys + [:CODE_BLOCK_DELIMITER]

    if block_types.include?(current_token.type)
      handle_generic_block_types(current_token.type)
    elsif current_token.type == :LINE_BREAK
      match_break
    elsif current_token.inline?
      match_paragraph
    else
      consume_current_token
    end
  end

  def current_token
    @tokens[@counter]
  end

  def next_token
    @tokens[@counter + 1]
  end

  def match_break
    if next_token.type == :LINE_BREAK
      @counter += 2
      Break.new
    else
      @counter += 1
      NewLine.new
    end
  end

  def handle_generic_block_types(token_type)
    return match_code_block if token_type == :CODE_BLOCK_DELIMITER

    group_siblings_into_block(token_type)
  end

  def group_siblings_into_block(block_type)
    block_class = BLOCK_TOKEN_TYPES[block_type]

    child_tokens = []
    child_tokens << consume_current_token while !end_of_file? && current_token.type == block_type

    block_class.new(child_tokens)
  end

  def match_paragraph
    child_tokens = []

    while !end_of_file? && (current_token.inline? || current_token.type == :NEW_LINE)
      # byebug unless current_token.inline?
      child_tokens << consume_current_token
    end

    Paragraph.new(child_tokens)
  end

  def match_code_block
    @counter += 1
    child_tokens = []

    while !end_of_file? && current_token.type != :CODE_BLOCK_DELIMITER
      child_tokens << current_token
      @counter += 1
    end

    @counter += 1 unless end_of_file?
    CodeBlock.new(child_tokens)
  end

  def consume_current_token
    frozen_current_token = current_token
    @counter += 1
    frozen_current_token
  end

  def end_of_file?
    @counter > @tokens.length - 1
  end
end
