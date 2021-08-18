# frozen_string_literal: true

module Shared
  # Handles logic for class methods for Inline Tokens.
  module InlineTokens
    def delimiter_length
      delimiter_token.length
    end

    def matches?(text)
      text.start_with?(delimiter_token) && valid_delimiter?(text[delimiter_length..])
    end

    def valid_delimiter?(text)
      delimiter_index = text.index(delimiter_token)
      !delimiter_index.nil?
    end

    def consume(text)
      delimiter_index = text[delimiter_length..].index(delimiter_token) + delimiter_length

      source = text[0..delimiter_index]
      new(source)
    end

    def delimiter_token
      const_get('DELIMITER_TOKEN')
    end
  end
end
