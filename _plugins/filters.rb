module Jekyll
  module StringFilter
    def humanize(input)
      StringHelper.humanize(input)
    end
  end

  module ArrayFilter
    def group_by_count(arr, count)
      arr.each_slice(count).to_a
    end
  end

  module PostFilter
    def latest_posts(posts, limit)
      posts[0..limit - 1]
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
Liquid::Template.register_filter(Jekyll::ArrayFilter)
Liquid::Template.register_filter(Jekyll::PostFilter)
