# frozen_string_literal: true

require './services/token_resolver'

# Scans and tokenises source text.
class Scanner
  def initialize(source_file)
    @source_file = source_file
  end

  def tokenise
    @source_file.split("\n").map { |line| TokenResolver.call(line) }.flatten
  end
end
