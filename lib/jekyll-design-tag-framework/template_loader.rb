module Jekyll
  module DesignTagFramework
    module TemplateLoader
      def load_template(site)
        site.includes_load_paths.each do |dir|
          path = PathManager.join(dir, "dtf")
          file = PathManager.join(path, template_name)
          return File.read(file, **site.file_read_opts) if File.file?(file)
        end
        nil
      end

      def get_template(site)
        t = load_template(site)
        t || template
      end
    end
  end
end
