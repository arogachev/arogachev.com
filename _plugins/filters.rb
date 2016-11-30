module Jekyll
  module InflectionsFilter
    def humanize(input)
      input.gsub('_', ' ').capitalize
    end
  end
end

Liquid::Template.register_filter(Jekyll::InflectionsFilter)
