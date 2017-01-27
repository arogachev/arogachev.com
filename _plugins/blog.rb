module Blog
  POST_EXCERPT_MARKER = '***'

  class PostGenerator < Jekyll::Generator
    def generate(site)
      site.posts.docs.each { |doc| convert(doc) }
    end

    def convert(doc)
      doc.data['excerpt_separator'] = POST_EXCERPT_MARKER
      doc.data['excerpt'] = PostExcerpt.new(doc)
      doc.content = content(doc)
    end

    def content(doc)
      content = doc.content.encode(universal_newline: true)
      content.gsub(POST_EXCERPT_MARKER, '').gsub(/\n{3,}/, "\n\n")
    end
  end

  class PostExcerpt < Jekyll::Excerpt
    protected

    def extract_excerpt(doc_content)
      doc_content = doc_content.partition(POST_EXCERPT_MARKER).last
      super
    end
  end
end
