# frozen_string_literal: true

require './lib/rosetta/service_base'
require './lib/rosetta/tokens/basic_list_item'
require './lib/rosetta/tokens/code_block_delimiter'
require './lib/rosetta/tokens/code_block'
require './lib/rosetta/tokens/header'
require './lib/rosetta/tokens/break'
require './lib/rosetta/tokens/line_break'
require './lib/rosetta/tokens/link'
require './lib/rosetta/tokens/numbered_list_item'
require './lib/rosetta/tokens/paragraph'
require './lib/rosetta/tokens/block_quote'
require './lib/rosetta/tokens/quote'
require './lib/rosetta/tokens/text'
require './lib/rosetta/tokens/basic_token'
require './lib/rosetta/tokens/basic_list'
require './lib/rosetta/tokens/numbered_list'
require './lib/rosetta/tokens/block_token'
require './lib/rosetta/tokens/new_line'

# Parse tokens into AST structure.
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
      # We don't want to insert newlines all the time, the desired
      # insertion is handled in paragraph grouping.
      nil
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
