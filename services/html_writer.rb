# frozen_string_literal: true

require './html_generator'

# Turns a tree of tokens into it's corresponding HTML output.
class HTMLWriter < ServiceBase
  def initialize(token_tree)
    @token_tree = token_tree
  end

  def call
    @html_tags = ["<body>\n"]

    html_generator = HTMLGenerator.new
    @html_tags << @token_tree.map do |token|
      html_generator.generate(token) if token.type.to_s.start_with?('HEADER')
    end.compact

    @html_tags << '<body/>'

    @html_tags.join
  end
end
