module Jekyll
  module StringFilter
    def linebreaks(input)
      input.encode(universal_newline: true).gsub("\n", '<br>')
    end

    def liquidify(input, data)
      template = Liquid::Template.parse(input)
      template.render(data)
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

  module PagesFilter
    def projects(pages)
      pages.select {|page| page.data['layout'] == 'portfolio_project'}.reverse
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
Liquid::Template.register_filter(Jekyll::ArrayFilter)
Liquid::Template.register_filter(Jekyll::PagesFilter)
