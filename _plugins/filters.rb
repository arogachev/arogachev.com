module Jekyll
  module StringFilter
    def humanize(input)
      StringHelper.humanize(input)
    end
  end

  module PostFilter
    def post_excerpt(input)
      marker = '<!--excerpt-->'
      StringHelper.string_between_markers(input, marker, marker).to_s.strip
    end

    def latest_posts(posts, limit)
      posts[0..limit - 1]
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
Liquid::Template.register_filter(Jekyll::PostFilter)
