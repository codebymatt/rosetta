# frozen_string_literal: true

# Turns a tree of tokens into it's corresponding HTML output.
class HTMLWriter < ServiceBase
  def initialize(token_tree)
    @token_tree = token_tree
  end

  def call
    @html_tags = ["<body>\n"]

    #  Implement Visitor Pattern for HTML parsing.
    @html_tags << @token_tree.map { |token| convert_token(token) if token.type == :HEADER_1 }.compact

    @html_tags << '<body/>'

    @html_tags.join
  end

  private

  def convert_token(token)
    "<h1>#{token.value}<h1/>\n"
  end
end
