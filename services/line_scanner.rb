# frozen_string_literal: true

require './services/token_resolver'

# Tokenises a given line
class LineScanner < ServiceBase
  def initialize(line)
    @line = line
  end

  def call
    TokenResolver.call(@line)
  end
end
