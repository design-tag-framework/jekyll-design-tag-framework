module Jekyll
  module DesignTagFramework
    class DesignElement < Liquid::Tag
      include TemplateLoader
      include DesignTag

      VARIABLE_SYNTAX = %r!\A\s*(?:[\w.-]+)\s*\z!x.freeze

      def initialize(tag_name, text, tokens, type = nil)
        super(tag_name, text, tokens)
        @tag_name = tag_name
        @type = type
        @required_params = []
        @optional_params = []
        if text.match(VARIABLE_SYNTAX)
          @variable = text.strip
        else
          @jdt_params = ParameterParser.new(tag_name, text)
        end
      end

      def expand_variable(context)
        unless context[@variable]
          raise ArgumentError, <<~MSG
            Invalid syntax for #{@tag_name} tag:

            #{@variable}

            #{valid_syntax}

          MSG
        end

        context[@variable]
      end

      def valid_syntax
        example_params = @required_params
        example_params = ["param1", "param2"] if @required_params.empty?
        i = 1
        example = example_params.map { |param| i += 1; "#{param}=\"#{i}\"" }.join(" ")
        examplepst = ""
        examplepst = " where #{example_params.map { |param| "post.#{param}"}.join(", ") } exists" unless @required_params.empty?
        optional = "\n\nOptional parameters: #{@optional_params.join(", ")}" unless @optional_params.empty?
        <<~MSG
          Valid syntax:

          "{% #{@tag_name} post %}" #{examplepst}

          or

          "{% #{@tag_name} #{example} %}"#{optional}
        MSG
      end

      def parse(tokens); end

      def render(context)
        site = context.registers[:site]

        if @jdt_params
          params = @jdt_params.parse_params(context)
        else
          params =  expand_variable(context)
        end

        @type ||= @jdt_params.type

        expand_author(params, site)
        validate_params(params)
        
        context.stack do
          params["classes"] = class_names
          context["element"] = params

          return Liquid::Template.parse(get_template(site).strip).render(context)
        end
      end

      def template_name
        return "#{@type}.html" unless @type.nil?

        "design_element.html"
      end

      def template
        "<div class=\"{{ element.classes }}\">{{ element.title }}</div>"
      end

      def class_names
        ["design_element", @type].compact.join(" ")
      end
    end
  end
end

Liquid::Template.register_tag("design_element", Jekyll::DesignTagFramework::DesignElement)
