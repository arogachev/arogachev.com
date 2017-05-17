module Jekyll
  module StringFilter
    def humanize(input)
      StringHelper.humanize(input)
    end

    def linebreaks(input)
      input.encode(universal_newline: true).gsub("\n", '<br>')
    end
  end

  module ArrayFilter
    def group_by_count(arr, count)
      arr.each_slice(count).to_a
    end

    def latest_items(items, limit)
      items[0..limit - 1]
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
Liquid::Template.register_filter(Jekyll::ArrayFilter)
