module Portfolio
  class ProjectGenerator < Jekyll::Generator
    def generate(site)
      projects = site.pages.select { |page| page.data['layout'] == 'portfolio_project' }
      projects.map!.with_index do |page, index|
        project = Portfolio::ProjectDecorator.new(page).decorate

        if index > 0
          project.data['prev'] = projects[index - 1]
        end

        next_project = projects[index + 1]
        if next_project
          project.data['next'] = next_project
        end

        project
      end
    end
  end
end
