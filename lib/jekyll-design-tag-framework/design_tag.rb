module Jekyll
  module DesignTagFramework
    module DesignTag
      def expand_author(params, site)
        author = params["author"]
        author = site.config["author"] if author.nil?
        if site.data["authors"].is_a?(Hash) && !params["author"].is_a?(Hash)
          params["author"] = site.data["authors"][author]
        end
      end

      def validate_params(params)
        return if params.nil?

        @required_params.each do |param|
          next if params.key?(param)

          raise ArgumentError, <<~MSG
            #{param} is not defined in #{@tag_name} tag

            #{valid_syntax}
          MSG
        end
      end
    end
  end
end
