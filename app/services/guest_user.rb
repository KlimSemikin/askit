# frozen_string_literal: true

class GuestUser
  def guest?
    true
  end

  def author?(_obj)
    false
  end

  private

  def method_missing(symbol, *args)
    return false if symbol.to_s.end_with?('_role?')

    super
  end

  def respond_to_missing?(symbol, include_private)
    return true if symbol.to_s.end_with?('_role?')

    super
  end
end
