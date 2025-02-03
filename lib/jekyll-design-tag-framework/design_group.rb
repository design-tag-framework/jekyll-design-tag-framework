module Jekyll
  module DesignTagFramework
    class DesignGroup < Liquid::Block
      include TemplateLoader
      include DesignTag

      def initialize(tag_name, text, tokens, type = nil)
        super(tag_name, text, tokens)
        @jdt_params = ParameterParser.new(tag_name, text)
        @type = type
        @tag_name = tag_name
        @parity = nil
        @required_params = []
        @optional_params = []
      end

      def render(context)
        text = super
        site = context.registers[:site]
        page = context.registers[:page]
        @parity = get_parity(page)
        params = @jdt_params.parse_params(context)
        validate_params(params)
        @type ||= @jdt_params.type

        context.stack do
          params["classes"] = class_names
          context["group"] = params
          text = Liquid::Template.parse(text).render(context)

          markdown_converter = site.find_converter_instance(::Jekyll::Converters::Markdown)

          text = markdown_converter.convert(text)

          context["content"] = text

          text = Liquid::Template.parse(get_template(site).strip).render(context)
        end
        text
      end

      def get_parity(page)
        if page["design_group_number"].nil?
          page["design_group_number"] = 1
        else
          page["design_group_number"] += 1
        end
        if page["design_group_number"].even?
          "design_group_even"
        else
          "design_group_odd"
        end
      end

      def template_name
        return "#{@type}.html" unless @type.nil?

        "design_group.html"
      end

      def template
        "<div class=\"{{ group.classes }}\">{{ content }}</div>"
      end

      def class_names
        ["design_group", @type, @parity].compact.join(" ")
      end

      def valid_syntax
        example_params = @required_params
        example_params = ["param1", "param2"] if @required_params.empty?
        i = 1
        example = example_params.map { |param| i += 1; "#{param}=\"#{i}\"" }.join(" ")
        optional = "\n\nOptional parameters: #{@optional_params.join(", ")}" unless @optional_params.empty?
        <<~MSG
          Valid syntax:

          "{% #{@tag_name} #{example} %}"
          content..
          {% end#{@tag_name} %}#{optional}
        MSG
      end
    end
  end
end

Liquid::Template.register_tag("design_group", Jekyll::DesignTagFramework::DesignGroup)
