class Jpegoptimize < Nanoc::Filter
  identifier :jpegoptimize
  type       :binary

  def run(filename, params = {})
    system(
      'convert',
      '-resize',
      params[:width].to_s,
      '-quality',
      params[:quality].to_s,
      filename,
      output_filename
    )
  end
end
