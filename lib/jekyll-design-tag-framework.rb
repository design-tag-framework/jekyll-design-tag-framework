require "jekyll"
require "shellwords"
require "jekyll-design-tag-framework/version"
require "jekyll-design-tag-framework/template_loader"
require "jekyll-design-tag-framework/design_tag"
require "jekyll-design-tag-framework/parameter_parser"
require "jekyll-design-tag-framework/design_group"
require "jekyll-design-tag-framework/design_element"
require "jekyll-design-tag-framework/convenience_types"
require "jekyll-design-tag-framework/picture_element"

module Jekyll
  module DesignTagFramework
    module ImageAssetFilter
      def asset_expand(input, arg, alt_extension = nil)
        dirname = File.dirname(input)
        extension = File.extname(input)
        basename = File.basename(input, extension)
        extension = alt_extension unless alt_extension.nil?

        "#{dirname}/#{basename}-#{arg}#{extension}"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::DesignTagFramework::ImageAssetFilter)


Jekyll::Hooks.register :site, :post_write do |site|
  # code to call after Jekyll renders a page
  brand_config = site.config["brand"]
  if brand_config && brand_config["image"] && site.config["generate_favicon"]
    src_file = File.join(site.source, site.config["brand"]["image"])
    extension = File.extname(src_file)
    # basename = File.basename(src_file, extension)
    unless File.exist?(src_file)
      throw "Could not find file #{src_file}"
    end

    dst_file = File.join(site.dest, "favicon.ico")

    cmd = "magick #{src_file.shellescape} -alpha off -resize 48x48 #{dst_file.shellescape}"
    system(cmd)

    dst_file = File.join(site.dest, "favicon512x512.png")

    cmd = "magick #{src_file.shellescape} -resize 512x512 #{dst_file.shellescape}"
    system(cmd)

  end

end
