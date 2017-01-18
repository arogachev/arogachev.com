require 'yaml'
require_relative '_components/resume/generators'

GENERATED_DIR = '_generated'
ASSETS_DIR = 'assets'
FILES_DIR = "#{ASSETS_DIR}/files"
IMAGES_DIR = "#{ASSETS_DIR}/images"

task default: %w[resume:generate_files portfolio:generate_main_images]

namespace :resume do
  module ResumeConfig
    GENERATED_RESUME_DIR = "#{GENERATED_DIR}/resume"

    RAW_DATA_DIR = '_data/resume'
    RAW_DATA = Rake::FileList.new("#{RAW_DATA_DIR}/**/*.yml")
    DATA_DIR = GENERATED_RESUME_DIR
    DATA_FILE = "#{DATA_DIR}/data.yml"

    RAW_TEMPLATES_DIR = '_components/resume/templates'
    RAW_TEMPLATES = Rake::FileList.new("#{RAW_TEMPLATES_DIR}/*.md")
    TEMPLATES_DIR = GENERATED_RESUME_DIR
    TEMPLATES_REGEX = Regexp.new("#{TEMPLATES_DIR}/.+\\.md")
    TEMPLATES = RAW_TEMPLATES.pathmap("%{^#{RAW_TEMPLATES_DIR}/,#{TEMPLATES_DIR}/}p")
  end

  include ResumeConfig

  desc 'Merge separate YAML files into one and decorate it with additional calculated values'
  task generate_data: DATA_FILE

  directory GENERATED_DIR

  file DATA_FILE => RAW_DATA.add(GENERATED_DIR) do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating data #{t.name}"
    Resume::DataGenerator.new(RAW_DATA_DIR, t.name).generate
  end

  desc 'Convert Markdown raw templates (with Liquid syntax) to regular Markdown templates'
  task convert_templates: TEMPLATES

  rule TEMPLATES_REGEX => [->(f) { source_for_md(f) }, DATA_FILE] do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating template #{t.name}"
    Resume::TemplateConverter.new(t.source, DATA_FILE, t.name).convert
  end

  def source_for_md(md_file)
    RAW_TEMPLATES.detect do |f|
      f == md_file.pathmap("%{^#{TEMPLATES_DIR}/,#{RAW_TEMPLATES_DIR}/}p")
    end
  end

  desc 'Convert Markdown templates to docx files'
  task generate_files: TEMPLATES.pathmap("%{^#{GENERATED_DIR}/,#{FILES_DIR}/}X.docx")

  directory ASSETS_DIR

  rule '.docx' => [->(f) { source_for_docx(f) }, ASSETS_DIR] do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating file #{t.name}"
    sh "pandoc -o #{t.name} #{t.source}"
  end

  def source_for_docx(docx_file)
    TEMPLATES.detect do |f|
      f.ext == docx_file.pathmap("%{^#{FILES_DIR}/,#{GENERATED_DIR}/}X")
    end
  end
end

namespace :portfolio do
  module PortfolioConfig
    PROJECTS_IMAGES_DIR = "#{IMAGES_DIR}/portfolio/projects"
    HOME_PAGE_IMAGES = Rake::FileList.new("#{PROJECTS_IMAGES_DIR}/**/home.png")
  end

  include PortfolioConfig

  desc 'Generate main images for projects'
  task generate_main_images: HOME_PAGE_IMAGES.pathmap('%d/main.jpg')

  rule '.jpg' => ->(f) { source_for_jpg(f) } do |t|
    sh "convert #{t.source} -crop 1280x1280+0+0 -resize 700x700 #{t.name}"
  end

  def source_for_jpg(jpg_file)
    HOME_PAGE_IMAGES.detect do |f|
      f.pathmap('%d') == jpg_file.pathmap('%d')
    end
  end
end
