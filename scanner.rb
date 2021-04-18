# frozen_string_literal: true

require './token'

# Scans and tokenises source text.
class Scanner
  def initialize(source_file)
    @source_file = source_file
    @tokens = []
  end

  def tokenise
    @source_file.split("\n").each do |line|
      @tokens << Token.new(line)
    end

    @tokens
  end
end
