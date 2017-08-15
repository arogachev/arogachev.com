require 'helper'
include Portfolio

class Project
  def initialize(data={}, name: nil)
    @data = data
    @name = name
    @content = 'content'
  end

  attr_accessor :data, :name, :content
end

RSpec.describe ProjectDecorator do
  describe '#add_image' do
    it 'adds link to main image' do
      project = Project.new(name: '2016-2-zernovye-maslichnye-kazakhstan.md')
      ProjectDecorator.new(project).add_image

      image = '/assets/images/portfolio/zernovye-maslichnye-kazakhstan/main.jpg'
      expect(project.data['image']).to eq(image)
    end
  end

  describe '#add_permalink' do
    context 'with not numbered project' do
      it 'removes year and file extension' do
        project = Project.new(name: '2011-bars-stroy.md')
        ProjectDecorator.new(project).add_permalink

        expect(project.data['permalink']).to eq('/portfolio/bars-stroy/')
      end
    end

    context 'with numbered project' do
      it 'removes year, number and file extension' do
        project = Project.new(name: '2016-2-zernovye-maslichnye-kazakhstan.md')
        ProjectDecorator.new(project).add_permalink

        expect(project.data['permalink']).to eq('/portfolio/zernovye-maslichnye-kazakhstan/')
      end
    end
  end

  describe '#add_period' do
    context "with project's data" do
      context "with year" do
        it "assigns it as is" do
          project = Project.new({'year' => 2013})
          ProjectDecorator.new(project).add_period

          expect(project.data['period']).to eq('2013')
        end
      end

      context "with start and end years" do
        it 'adds both years' do
          project = Project.new({'start_year' => 2011, 'end_year' => 2013})
          ProjectDecorator.new(project).add_period

          expect(project.data['period']).to eq('2011 - 2013')
        end
      end

      context "with start year only" do
        it 'adds start year and special word' do
          project = Project.new({'start_year' => 2016, 'end_year' => nil})
          ProjectDecorator.new(project).add_period

          expect(project.data['period']).to eq('2016 - Present')
        end
      end
    end

    context "with passed data" do
      context "with year" do
        it "assigns it as is" do
          project = Project.new
          data = {'year' => 2013}
          ProjectDecorator.new(project).add_period(data)

          expect(data['period']).to eq('2013')
        end
      end

      context "with start and end years" do
        it 'adds both years' do
          project = Project.new
          data = {'start_year' => 2011, 'end_year' => 2013}
          ProjectDecorator.new(project).add_period(data)

          expect(data['period']).to eq('2011 - 2013')
        end
      end

      context "with start year only" do
        it 'adds start year and special word' do
          project = Project.new
          data = {'start_year' => 2016, 'end_year' => nil}
          ProjectDecorator.new(project).add_period(data)

          expect(data['period']).to eq('2016 - Present')
        end
      end
    end
  end

  describe '#decorate_technologies' do
    it 'adds new data' do
      project = Project.new({'technologies' => ['Ruby', 'Ruby on Rails', 'XSLT', 'MySQL']})
      ProjectDecorator.new(project).decorate_technologies(slugs: {'Ruby on Rails' => 'rails'}, skip_logos: ['XSLT'])

      expect(project.data['technologies']).to eq([
        {'name' => 'Ruby', 'slug' => 'ruby', 'has_logo' => true},
        {'name' => 'Ruby on Rails', 'slug' => 'rails', 'has_logo' => true},
        {'name' => 'XSLT', 'slug' => 'xslt', 'has_logo' => false},
        {'name' => 'MySQL', 'slug' => 'mysql', 'has_logo' => true},
      ])
    end
  end

  describe '#decorate_site' do
    context 'with not link' do
      it 'leaves it as is' do
        project = Project.new({'site' => {'link' => 'https://margin.kz/', 'active' => true}})
        ProjectDecorator.new(project).decorate_site

        expect(project.data['site']).to eq({'link' => 'https://margin.kz/', 'active' => true})
      end
    end

    context 'with link' do
      it 'marks it as active' do
        project = Project.new({'site' => 'https://margin.kz/'})
        ProjectDecorator.new(project).decorate_site

        expect(project.data['site']).to eq({'link' => 'https://margin.kz/', 'active' => true})
      end
    end
  end

  describe '#decorate_company' do
    context 'with no data' do
      it 'does nothing' do
        project = Project.new
        ProjectDecorator.new(project).decorate_company

        expect(project.data['company']).to be_nil
      end
    end

    context 'with company name' do
      it 'converts it to hash and adds link' do
        project = Project.new({'company' => 'Zernovye & Maslichnye. Kazakhstan'})
        ProjectDecorator.new(project).decorate_company

        expect(project.data['company']).to eq({
          'name' => 'Zernovye & Maslichnye. Kazakhstan',
          'link' => '/resume/#zernovye--maslichnye-kazakhstan',
        })
      end
    end

    context 'with individual type' do
      it 'converts it to hash and does not add link' do
        project = Project.new({'company' => ProjectDecorator::COMPANY_INDIVIDUAL})
        ProjectDecorator.new(project).decorate_company

        expect(project.data['company']).to eq({'name' => 'Individual'})
      end
    end
  end

  describe '#decorate_companies' do
    context 'with no data' do
      it 'does nothing' do
        project = Project.new
        ProjectDecorator.new(project).decorate_companies

        expect(project.data['companies']).to be_nil
      end
    end

    context 'with data' do
      it 'adds period and link if necessary' do
        project = Project.new({
          'companies' => [
            {'name' => 'INSY', 'year' => 2013},
            {'name' => 'Individual', 'start_year' => 2013, 'end_year' => 2016},
          ],
        })
        ProjectDecorator.new(project).decorate_companies

        expect(project.data['companies']).to eq([
          {'name' => 'INSY', 'year' => 2013, 'period' => '2013', 'link' => '/resume/#insy'},
          {'name' => 'Individual', 'start_year' => 2013, 'end_year' => 2016, 'period' => '2013 - 2016'},
        ])
      end
    end
  end

  describe '#decorate_screenshots' do
    it 'adds new data' do
      data = {'screenshots' => ['home', 'agrarian_map']}
      project = Project.new(data, name: '2016-2-zernovye-maslichnye-kazakhstan.md')
      ProjectDecorator.new(project).decorate_screenshots

      expect(project.data['screenshots']).to eq([
        {'title' => 'Home', 'url' => '/assets/images/portfolio/zernovye-maslichnye-kazakhstan/home.png'},
        {
          'title' => 'Agrarian map',
          'url' => '/assets/images/portfolio/zernovye-maslichnye-kazakhstan/agrarian_map.png',
        },
      ])
    end
  end

  describe '#add_headings' do
    it 'adds headings tree parsed from Markdown content' do
      allow(MarkdownHelper).to receive(:headings_tree).and_return(['Background', 'Development', 'Further development'])
      project = Project.new
      ProjectDecorator.new(project).add_headings

      expect(project.data['headings']).to eq(['Background', 'Development', 'Further development'])
    end
  end

  describe '#add_nearby_pages' do
    context 'with no pages' do
      it 'does nothing' do
        project = Project.new
        ProjectDecorator.new(project).add_nearby_pages

        expect(project.data['previous']).to be_nil
        expect(project.data['next']).to be_nil
      end
    end

    context 'with pages and list index' do
      context 'with first page' do
        it 'adds next page only' do
          project = Project.new(name: '2011-bars-stroy.md')
          next_project = Project.new(name: '2012-chip.md')
          projects = [project, next_project]
          ProjectDecorator.new(project, pages: projects, list_index: 0).add_nearby_pages

          expect(project.data['next']).to eq(next_project)
          expect(project.data['previous']).to be_nil
        end
      end

      context 'with page in the middle' do
        it 'adds both previous and next pages' do
          prev_project = Project.new(name: '2011-bars-stroy.md')
          project = Project.new(name: '2012-chip.md')
          next_project = Project.new(name: '2016-2-zernovye-maslichnye-kazakhstan.md')
          projects = [prev_project, project, next_project]
          ProjectDecorator.new(project, pages: projects, list_index: 1).add_nearby_pages

          expect(project.data['previous']).to eq(prev_project)
          expect(project.data['next']).to eq(next_project)
        end
      end

      context 'with last page' do
        it 'adds previous page only' do
          prev_project = Project.new(name: '2011-bars-stroy.md')
          project = Project.new(name: '2012-chip.md')
          projects = [prev_project, project]
          ProjectDecorator.new(project, pages: projects, list_index: 1).add_nearby_pages

          expect(project.data['previous']).to eq(prev_project)
          expect(project.data['next']).to be_nil
        end
      end
    end

    context 'with pages and no list index' do
      context 'with first page' do
        it 'adds next page only' do
          project = Project.new(name: '2011-bars-stroy.md')
          next_project = Project.new(name: '2012-chip.md')
          projects = [project, next_project]
          ProjectDecorator.new(project, pages: projects).add_nearby_pages

          expect(project.data['next']).to eq(next_project)
          expect(project.data['previous']).to be_nil
        end
      end

      context 'with page in the middle' do
        it 'adds both previous and next pages' do
          prev_project = Project.new(name: '2011-bars-stroy.md')
          project = Project.new(name: '2012-chip.md')
          next_project = Project.new(name: '2016-2-zernovye-maslichnye-kazakhstan.md')
          projects = [prev_project, project, next_project]
          ProjectDecorator.new(project, pages: projects).add_nearby_pages

          expect(project.data['previous']).to eq(prev_project)
          expect(project.data['next']).to eq(next_project)
        end
      end

      context 'with last page' do
        it 'adds previous page only' do
          prev_project = Project.new(name: '2011-bars-stroy.md')
          project = Project.new(name: '2012-chip.md')
          projects = [prev_project, project]
          ProjectDecorator.new(project, pages: projects).add_nearby_pages

          expect(project.data['previous']).to eq(prev_project)
          expect(project.data['next']).to be_nil
        end
      end
    end
  end

  describe '#decorate' do
    it 'decorates portfolio project page with new data' do
      project = Project.new
      decorator = ProjectDecorator.new(project)

      expect(decorator).to receive(:add_image)
      expect(decorator).to receive(:add_permalink)
      expect(decorator).to receive(:add_period)
      expect(decorator).to receive(:decorate_technologies)
      expect(decorator).to receive(:decorate_site)
      expect(decorator).to receive(:decorate_company)
      expect(decorator).to receive(:decorate_companies)
      expect(decorator).to receive(:decorate_screenshots)
      expect(decorator).to receive(:add_headings)
      expect(decorator).to receive(:add_nearby_pages)

      decorator.decorate
    end
  end

  describe '.decorate_collection' do
    it "decorates portfolio projects' pages with new data" do
      project = Project.new(name: '2011-bars-stroy.md')
      next_project = Project.new(name: '2012-chip.md')
      projects = [project, next_project]
      new_stub = Proc.new do
        decorator_double = instance_double(ProjectDecorator)
        expect(decorator_double).to receive(:decorate)
        decorator_double
      end

      expect(ProjectDecorator).to receive(:new).with(project, pages: projects, list_index: 0) { new_stub.call }
      expect(ProjectDecorator).to receive(:new).with(next_project, pages: projects, list_index: 1) { new_stub.call }

      ProjectDecorator.decorate_collection(projects)
    end
  end
end
