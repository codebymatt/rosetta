# frozen_string_literal: true

require './lib/rosetta/service_base'
require './lib/rosetta/services/token_resolver'

# Scans and tokenises source text.
class InputScanner < ServiceBase
  def initialize(input)
    @input = input
  end

  def call
    @input.split("\n").map { |line| TokenResolver.call(line) }.flatten
  end
end
