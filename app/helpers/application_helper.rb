module ApplicationHelper
  def error_tag(record, attribute)
    error_message = record.errors[attribute].first
    return unless error_message

    content_tag :div, error_message, class: "error-message"
  end

  def shorten_wallet_address(address)
    address.gsub(/\A(.{5}).*?(.{5})\z/, "\\1...\\2")
  end
end
