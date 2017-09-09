module Jekyll
  class Collapse < Liquid::Block
    def initialize(tag_name, markup, options)
      super
      @title = markup.gsub("'", '').rstrip
    end

    def render(context)
      template = File.open('_includes/tags/collapse.html', 'rb').read
      params = {'id' => Inflector.slugify(@title), 'title' => @title, 'content' => super}
      Liquid::Template.parse(template).render('include' => params)
    end
  end
end

Liquid::Template.register_tag('collapse', Jekyll::Collapse)
