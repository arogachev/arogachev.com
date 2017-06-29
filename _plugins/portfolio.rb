module Portfolio
  class ProjectGenerator < Jekyll::Generator
    def generate(site)
      site.pages.map! do |page|
        page.data['layout'] == 'portfolio_project' ? Portfolio::ProjectDecorator.new(page).decorate : page
      end
    end
  end
end
