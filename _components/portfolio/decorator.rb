module Portfolio
  class ProjectDecorator
    IMAGES_DIR = '/assets/images/portfolio'
    COMPANY_INDIVIDUAL = 'Individual'

    def initialize(page, pages: nil, list_index: nil)
      @page = page
      @data = page.data
      @pages = pages
      @list_index = list_index
      @slug = nil
    end

    def decorate
      add_image
      add_permalink
      add_period
      decorate_technologies(slugs: {'Ruby on Rails' => 'rails'}, skip_logos: ['UMI.CMS', 'XSLT', '1C-Bitrix'])

      decorate_site
      decorate_company
      decorate_companies

      decorate_screenshots
      add_headings

      add_nearby_pages
    end

    def self.decorate_collection(pages)
      pages.each_with_index do |page, index|
        new(page, pages: pages, list_index: index).decorate
      end
    end

    def add_image
      @data['image'] = "#{IMAGES_DIR}/#{slug}/main.jpg"
    end

    def add_permalink
      @data['permalink'] = "/portfolio/#{slug}/"
    end

    def add_period(data=nil)
      if data.nil?
        data = @data
      end

      if data['year']
        data['period'] = data['year'].to_s
      else
        end_year = data['end_year'] || 'Present'
        data['period'] = "#{data['start_year']} - #{end_year}"
      end
    end

    def decorate_technologies(slugs: [], skip_logos: [])
      @data['technologies'].map! do |technology|
        {
          'name' => technology,
          'slug' => slugs[technology] || Inflector.slugify(technology),
          'has_logo' => !skip_logos.include?(technology),
        }
      end
    end

    def decorate_site
      unless @data['site'].is_a?(String)
        return
      end

      @data['site'] = {'link' => @data['site'], 'active' => true}
    end

    def decorate_company
      if @data['company'].nil?
        return
      end

      data = {'name' => @data['company']}
      add_company_link(data)
      @data['company'] = data
    end

    def decorate_companies
      if @data['companies'].nil?
        return
      end

      @data['companies'].each do |company|
        add_period(company)
        add_company_link(company)
      end
    end

    def decorate_screenshots
      @data['screenshots'].map! do |screenshot|
        {
          'url' => "#{IMAGES_DIR}/#{slug}/#{screenshot}.png",
          'title' => screenshot.gsub('_', ' ').capitalize,
        }
      end
    end

    def add_headings
      @data['headings'] = MarkdownHelper::headings_tree(@page.content)
    end

    def add_nearby_pages
      if @pages.nil?
        return
      end

      if list_index > 0
        @page.data['previous'] = @pages[list_index - 1]
      end

      next_page = @pages[list_index + 1]
      if next_page
        @page.data['next'] = next_page
      end
    end

    private

    def slug
      if @slug
        @slug
      end

      matches = @page.name.match(/\d{4}(?:-\d{1,2})?-([\w-]+)/)
      @slug = matches.captures[0]
    end

    def add_company_link(data)
      if data['name'] == COMPANY_INDIVIDUAL
        return
      end

      slug = Inflector.slugify(data['name'], true)
      data['link'] = "/resume/##{slug}"
    end

    def list_index
      if @list_index
        @list_index
      end

      @list_index = @pages.index {|page| page.name == @page.name}
    end
  end
end
