# frozen_string_literal: true

class ApplicationService
  def initialize(...)
    raise 'Cannot initialize an abstract ApplicationService class'
  end

  def self.call(...)
    new(...).call
  end
end
