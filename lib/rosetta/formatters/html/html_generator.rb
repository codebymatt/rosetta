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

  def generate_block_quote(token)
    child_tokens = token.children.map { |child_token| generate(child_token) }

    ["<pre><blockquote>\n", child_tokens, "</blockquote></pre>\n"].join
  end

  def generate_code_block(token)
    child_tokens = token.children.map { |child_token| generate(child_token) }

    ["<pre><code>\n", child_tokens, "</code></pre>\n"].compact.join
  end

  def generate_new_line(_token)
    "\n"
  end

  def generate_quote(token)
    "#{token.value}\n"
  end

  def generate_text(token)
    token.value
  end

  def generate_break(_token)
    "</br>\n"
  end

  def generate_paragraph(token)
    child_tokens = token.children.map { |child_token| generate(child_token) }

    ["<p>\n", child_tokens, "</p>\n"].join
  end

  def generate_strikethrough(token)
    "<del>#{token.value}</del>"
  end

  def generate_italics(token)
    "<em>#{token.value}</em>"
  end

  def generate_inline_code(token)
    "<code>#{token.value}</code>"
  end

  def generate_bold(token)
    "<b>#{token.value}</b>"
  end

  def generate_link(token)
    "<a href='#{token.url}'>#{token.value}</a>"
  end

  private

  def define_header_generators
    (1..6).each do |header_level|
      method_name = "generate_header_#{header_level}"

      self.class.define_method(method_name) do |token|
        "<h#{header_level}>#{token.value}</h#{header_level}>\n"
      end
    end
  end

  def generate_list(child_tokens, tag)
    child_token_strings = child_tokens.map { |child_token| generate_list_item(child_token) }

    ["<#{tag}>\n", child_token_strings, "</#{tag}>\n"].join
  end
end
