# frozen_string_literal: true

# Generates HTML for a given AST token.
class HTMLGenerator
  def initialize
    define_header_generators
  end

  def generate(token)
    token.accept(self)
  end

  def generate_basic_list(token)
    generate_list(token.children, 'ul')
  end

  def generate_numbered_list(token)
    generate_list(token.children, 'ol')
  end

  def generate_list_item(token)
    "<li>#{token.value}</li>\n"
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

  def generate_list(child_tokens, tag)
    child_token_strings = child_tokens.map { |child_token| generate_list_item(child_token) }

    ["<#{tag}>\n", child_token_strings, "</#{tag}>\n"].flatten.join
  end
end
