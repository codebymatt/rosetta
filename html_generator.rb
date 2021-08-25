# frozen_string_literal: true

# Generates HTML for a given AST token.
class HTMLGenerator
  def initialize
    define_header_generators
  end

  def generate(token)
    token.accept(self)
  end

  private

  def define_header_generators
    (1..6).each do |header_level|
      method_name = "generate_header_#{header_level}"

      self.class.define_method(method_name) do |token|
        "<h#{header_level}>#{token.value}<h#{header_level}/>\n"
      end
    end
  end
end
