module Jekyll
  module DesignTagFramework
    class PictureElement < DesignElement
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "picture_element")
        @required_params = [ "src", "alt" ]
        @optional_params = [ "class", "height", "size-hint" ]
      end

      def template
        "<div class=\"{{ element.classes }}\"><img src=\"{{ element.src }}\"></div>"
      end
    end
  end
end

Liquid::Template.register_tag("picture_element", Jekyll::DesignTagFramework::PictureElement)
