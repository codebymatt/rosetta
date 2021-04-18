# frozen_string_literal: true

# Base Service class.
class Service
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
