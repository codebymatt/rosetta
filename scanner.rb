# frozen_string_literal: true

# require './tokens/token'
require './services/line_scanner'

# Scans and tokenises source text.
class Scanner
  def initialize(source_file)
    @source_file = source_file
    @tokens = []
  end

  def tokenise
    @source_file.split("\n").each do |line|
      @tokens << LineScanner.call(line)
    end

    @tokens
  end
end
