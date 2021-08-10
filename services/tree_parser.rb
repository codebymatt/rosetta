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
require './tokens/quote'
require './tokens/text'
require './tokens/basic_token'
require './tokens/block_token'

# Resolves token types from source text.
class TreeParser < ServiceBase
  def initialize(tokens)
    @tokens = tokens
    @final_index = @tokens.length - 1
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
    if current_token.type == :LINE_BREAK
      match_break
    elsif current_token.inline?
      match_paragraph
    elsif current_token.type == :CODE_BLOCK_DELIMITER
      match_code_block
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
      nil
    end
  end

  def match_paragraph
    child_tokens = []

    child_tokens << consume_current_token while current_token.inline? && !end_of_file?

    Paragraph.new(child_tokens)
  end

  def match_code_block
    @counter += 1
    child_tokens = []

    while current_token.type != :CODE_BLOCK_DELIMITER && !end_of_file?
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
    @counter >= @final_index
  end
end
