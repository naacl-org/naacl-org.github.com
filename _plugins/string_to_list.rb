#
# A liquid block for converting a space-seperated string to a list that can be
# iterated over. This is because there does not seem to be any way of using
# expressions in liquid at the places neccessary to iterate.
#

module Jekyll
  class StringToListBlock < Liquid::Block
    def initialize(tag_name, param_text, tokens)
      super
      @list_var = param_text.strip
    end

    def render(context)
      context[@list_var] = context[@list_var].split
      super
    end
  end
end

Liquid::Template.register_tag('stringtolist', Jekyll::StringToListBlock)
