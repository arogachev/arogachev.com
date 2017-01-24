require 'yaml'
require_relative '_components/resume/generators'

GENERATED_DIR = '_generated'
assets_dir = 'assets'
FILES_DIR = "#{assets_dir}/files"
images_dir = "#{assets_dir}/images"

task default: %w[resume:generate_files portfolio:generate_main_images]

namespace :resume do
  resume_generated_dir = "#{GENERATED_DIR}/resume"

  RESUME_RAW_DATA_DIR = '_data/resume'
  raw_data = Rake::FileList.new("#{RESUME_RAW_DATA_DIR}/**/*.yml")
  RESUME_DATA_FILE = "#{resume_generated_dir}/data.yml"

  RESUME_RAW_TEMPLATES_DIR = '_components/resume/templates'
  RESUME_RAW_TEMPLATES = Rake::FileList.new("#{RESUME_RAW_TEMPLATES_DIR}/*.md")
  RESUME_TEMPLATES_DIR = resume_generated_dir
  templates_regex = Regexp.new("#{RESUME_TEMPLATES_DIR}/.+\\.md")
  RESUME_TEMPLATES = RESUME_RAW_TEMPLATES.pathmap("%{^#{RESUME_RAW_TEMPLATES_DIR}/,#{RESUME_TEMPLATES_DIR}/}p")

  downloadable_files_spec = "%{^#{GENERATED_DIR}/,#{FILES_DIR}/}X"
  docx_files = RESUME_TEMPLATES.pathmap("#{downloadable_files_spec}.docx")
  pdf_files = RESUME_TEMPLATES.pathmap("#{downloadable_files_spec}.pdf")
  downloadable_files = docx_files.add(pdf_files)

  desc 'Merge separate YAML files into one and decorate it with additional calculated values'
  task generate_data: RESUME_DATA_FILE

  directory GENERATED_DIR

  file RESUME_DATA_FILE => raw_data.add(GENERATED_DIR) do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating data #{t.name}"
    Resume::DataGenerator.new(RESUME_RAW_DATA_DIR, t.name).generate
  end

  desc 'Convert Markdown raw templates (with Liquid syntax) to regular Markdown templates'
  task convert_templates: RESUME_TEMPLATES

  rule templates_regex => [->(f) { source_for_md(f) }, RESUME_DATA_FILE] do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating template #{t.name}"
    Resume::TemplateConverter.new(t.source, RESUME_DATA_FILE, t.name).convert
  end

  def source_for_md(md_file)
    RESUME_RAW_TEMPLATES.detect do |f|
      f == md_file.pathmap("%{^#{RESUME_TEMPLATES_DIR}/,#{RESUME_RAW_TEMPLATES_DIR}/}p")
    end
  end

  desc 'Convert Markdown templates to downloadable files (docx and pdf)'
  task generate_files: downloadable_files

  directory assets_dir

  rule '.docx' => [->(f) { source_for_downloadable_file(f) }, assets_dir] do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating file #{t.name}"
    sh "pandoc -o #{t.name} #{t.source}"
  end

  rule '.pdf' => [->(f) { source_for_downloadable_file(f) }, assets_dir] do |t|
    mkdir_p t.name.pathmap('%d')
    puts "Generating file #{t.name}"
    sh "pandoc -fmarkdown-implicit_figures -V geometry:margin=0.2in -o #{t.name} #{t.source}"
  end

  def source_for_downloadable_file(downloadable_file)
    RESUME_TEMPLATES.detect do |f|
      f.ext == downloadable_file.pathmap("%{^#{FILES_DIR}/,#{GENERATED_DIR}/}X")
    end
  end
end

namespace :portfolio do
  PORTFOLIO_HOME_PAGE_IMAGES = Rake::FileList.new("#{images_dir}/portfolio/projects/**/home.png")

  desc 'Generate main images for projects'
  task generate_main_images: PORTFOLIO_HOME_PAGE_IMAGES.pathmap('%d/main.jpg')

  rule '.jpg' => ->(f) { source_for_jpg(f) } do |t|
    sh "convert #{t.source} -crop 1280x1280+0+0 -resize 700x700 #{t.name}"
  end

  def source_for_jpg(jpg_file)
    PORTFOLIO_HOME_PAGE_IMAGES.detect do |f|
      f.pathmap('%d') == jpg_file.pathmap('%d')
    end
  end
end
