module Jekyll
  module DesignTagFramework
    class ParameterParser
      VALID_SYNTAX = %r!
            ([\w-]+)\s*=\s*
            (?:"([^"\\]*(?:\\.[^"\\]*)*)"|'([^'\\]*(?:\\.[^'\\]*)*)'|([\w.-]+))
          !x.freeze

      FULL_VALID_SYNTAX = %r!\A\s*(?:#{VALID_SYNTAX}(?=\s|\z)\s*)*\z!.freeze

      def initialize(tag_name, raw_params)
        @tag_name = tag_name
        @raw_params = raw_params.strip

        validate_params
      end

      def validate_params
        unless FULL_VALID_SYNTAX.match?(@raw_params)
          raise ArgumentError, <<~MSG
            Invalid syntax for #{@tag_name} tag:

            #{@raw_params}

            Valid syntax:

            #{syntax_example}

          MSG
        end
      end

      def syntax_example
        "{% #{@tag_name} param='value' param2='value' %}"
      end

      def parse_params(context)
        @params = {}
        @raw_params.scan(VALID_SYNTAX) do |key, d_quoted, s_quoted, variable|
          value = if d_quoted
                    d_quoted.include?('\\"') ? d_quoted.gsub('\\"', '"') : d_quoted
                  elsif s_quoted
                    s_quoted.include?("\\'") ? s_quoted.gsub("\\'", "'") : s_quoted
                  elsif variable
                    context[variable]
                  end
          @params[key] = value
        end
        @params
      end
      
      def type
        @params["type"] if @params.key? "type"
      end

    end
  end
end
