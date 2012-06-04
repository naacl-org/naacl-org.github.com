#
# This is a filter to do inline textile.
# This can be useful for eg tiles, where it is desirable to do basic escaping
# and minimal formatting, but not to have paragraphs or other block elements.
#

require 'redcloth'

module Jekyll
  module InlineTextile
    def inline_textile(title)
      r = RedCloth.new(title)
      r.lite_mode = true
      r.to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::InlineTextile)
