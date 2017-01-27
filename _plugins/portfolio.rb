module Jekyll
  class PortfolioProjectPage < Page
    def initialize(site, base, dir, project)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'portfolio_project.html')
      self.data['title'] = project['title']
      self.data['permalink'] = "/portfolio/projects/#{project['name']}/"
      self.data['project'] = project
    end
  end

  class PortfolioPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'portfolio_project'
        projects = site.data['portfolio']['projects']
        projects.each do |project|
          dir = File.join('portfolio', 'projects', project['name'])
          site.pages << PortfolioProjectPage.new(site, site.source, dir, project)
        end
      end
    end
  end
end
