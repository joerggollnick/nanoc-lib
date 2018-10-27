class Brotli < Nanoc::Filter
  identifier :brotli
  type       :text => :binary

  def run(content, params = { quality => 11 })
    Open3.pipeline_w( "brotli --quality=#{params[:quality].to_s} -o #{output_filename}" ) { |input, ts|
      input.puts( content )
      input.close
    }
  end
end
