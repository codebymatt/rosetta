# frozen_string_literal: true

# Handles logic for Line Break tokens
class LineBreak
  def initialize(source_text)
    @source_text = source_text
  end

  def type
    :LINE_BREAK
  end

  def extract_value_from_text
    ''
  end
end
