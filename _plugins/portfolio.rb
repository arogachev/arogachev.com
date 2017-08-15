module Portfolio
  class ProjectGenerator < Jekyll::Generator
    def generate(site)
      projects = site.pages.select { |page| page.data['layout'] == 'portfolio_project' }
      Portfolio::ProjectDecorator.decorate_collection(projects)
    end
  end
end
