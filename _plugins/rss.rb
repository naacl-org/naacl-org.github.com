#
# Support for .rss files.
#

# This is just the identity converter set to handle .rss files.
module Jekyll
  class RssConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /rss/i
    end

    def output_ext(ext)
      ".rss"
    end

    def convert(content)
      content
    end
  end
end
