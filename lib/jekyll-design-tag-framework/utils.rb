module Jekyll
  module DesignTagFramework
    def validate_author(author)
      keys = ["name"]
      keys.each do |key|
        next if author.key?(key)
        raise ArgumentError, <<~MSG
          Author #{author} has no parameter #{key}
        MSG
      end
    end
    module_function :validate_author

  end
end
