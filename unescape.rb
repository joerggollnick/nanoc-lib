class Unescape < Nanoc::Filter
  identifier :unescape
  type :text

  def run(content, params = {})
    return CGI::unescape(content)
  end
end
