module ContentsHelper

  def header(content)
    if (@current_publisher || current_user).publisher? && content.content_publishers.any?
      content.content_publishers.first.header
    elsif (@current_publisher || current_user).creator?
      content.header
    else
      nil
    end
  end

  def footer(content)
    if (@current_publisher || current_user).publisher? && content.content_publishers.any?
      content.content_publishers.first.footer
    elsif (@current_publisher || current_user).creator?
      content.footer
    else
      nil
    end
  end

end
