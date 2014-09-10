module WallsHelper

  def parse_hypecode(text)
    unless text.blank?
      raw simple_format(text.gsub(/(#[^\s]+)/,'<span class=\'large\'>\1</span>'))
    end
  end
end
