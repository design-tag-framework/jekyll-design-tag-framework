require "jekyll-design-tag-framework/design_group"
require "jekyll-design-tag-framework/design_element"
require "jekyll-design-tag-framework/utils"

module Jekyll
  module DesignTagFramework
    class PostGroup < DesignTagFramework::DesignGroup
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "post_group")
      end
    end

    class PostElement < DesignElement
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "post_element")
        @required_params = [ "title", "author", "url", "date" ]
        @optional_params = [ "description", "image"]
      end

      def validate_params(params)
        super
        DesignTagFramework.validate_author(params["author"])
      end
    end
  end
end


Liquid::Template.register_tag("post_group", Jekyll::DesignTagFramework::PostGroup)
Liquid::Template.register_tag("post_element", Jekyll::DesignTagFramework::PostElement)


module Jekyll
  module DesignTagFramework
    class ProjectGroup < DesignTagFramework::DesignGroup
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "project_group")
      end
    end

    class ProjectElement < DesignElement
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "project_element")
        @required_params = [ "title" ]
        @optional_params = %w(url author image description)
      end
    end
  end
end

Liquid::Template.register_tag("project_group", Jekyll::DesignTagFramework::ProjectGroup)
Liquid::Template.register_tag("project_element", Jekyll::DesignTagFramework::ProjectElement)

module Jekyll
  module DesignTagFramework
    class FeatureGroup < DesignTagFramework::DesignGroup
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "feature_group")
      end
    end

    class FeatureElement < DesignElement
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "feature_element")
        @required_params = [ "title" ]
        @optional_params = [ "description", "url", "icon-path", "icon-class" ]
      end
    end
  end
end

Liquid::Template.register_tag("feature_group", Jekyll::DesignTagFramework::FeatureGroup)
Liquid::Template.register_tag("feature_element", Jekyll::DesignTagFramework::FeatureElement)

module Jekyll
  module DesignTagFramework
    class AuthorElement < DesignElement
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "author_element")
        @required_params = [ "author" ]
        @optional_params = [ "class" ]
      end

      def validate_params(params)
        super
        DesignTagFramework.validate_author(params["author"])
      end
    end
  end
end

Liquid::Template.register_tag("author_element", Jekyll::DesignTagFramework::AuthorElement)

module Jekyll
  module DesignTagFramework
    class AlertElement < DesignGroup
      def initialize(tag_name, text, tokens)
        super(tag_name, text, tokens, "alert_element")
        @optional_params = [ "variant" ]
      end
    end
  end
end

Liquid::Template.register_tag("alert_element", Jekyll::DesignTagFramework::AlertElement)
