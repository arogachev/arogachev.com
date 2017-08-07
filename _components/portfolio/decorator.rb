module Portfolio
  class ProjectDecorator
    IMAGES_DIR = '/assets/images/portfolio/projects'

    def initialize(page)
      @page = page
    end

    def decorate
      slug = self.class.slugify(@page.name)
      @page.data['permalink'] = "/portfolio/projects/#{slug}/"

      if @page.data['end_year']
        @page.data['period'] = @page.data['start_year']
      else
        end_year = @page.data['end_year'] || 'Present'
        @page.data['period'] = "#{@page.data['start_year']} - #{end_year}"
      end

      @page.data['image'] = "#{IMAGES_DIR}/#{slug}/main.jpg"
      @page.data['screenshots'].map! do |screenshot|
        {
            'url' => "#{IMAGES_DIR}/#{slug}/#{screenshot}.png",
            'title' => self.class.screenshot_title(screenshot),
        }
      end

      @page
    end

    private

    def self.slugify(filename)
      matches = filename.match(/\d{4}(?:-\d{1,2})?-([\w-]+)/)
      matches.nil? ? nil : matches.captures[0]
    end

    def self.screenshot_title(filename)
      filename.gsub('_', ' ').capitalize
    end
  end
end
