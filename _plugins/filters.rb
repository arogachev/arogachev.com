module Jekyll
  module StringFilter
    def humanize(input)
      StringHelper.humanize(input)
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
