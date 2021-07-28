# frozen_string_literal: true

# require './tokens/token'
# require './services/line_scanner'
require './services/token_resolver'

# Scans and tokenises source text.
class Scanner
  def initialize(source_file)
    @source_file = source_file
  end

  def tokenise
    @source_file.split("\n").map do |line|
      TokenResolver.call(line)
    end
  end
end
