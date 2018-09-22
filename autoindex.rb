# frozen_string_literal: true

module Nanoc::Helpers::Autoindex
  # @option ext [String]
  #
  # @return [Array]
  def articles( ext = 'adoc' )
    blk = -> { @items.select { |item| item.identifier.ext == ext && !(item[:is_hidden]) && !(item.identifier.without_ext == '/index') } }
    if @items.frozen?
      @article_items ||= blk.call
    else
      blk.call
    end
  end

  # @option ext [String]
  #
  # @return [Array]
  def sorted_articles( ext = 'adoc' )
    blk = -> { articles( ext ).sort_by { |a| a.identifier.without_ext } }
    
    if @items.frozen?
      @sorted_article_items ||= blk.call
    else
      blk.call
    end
  end
end
