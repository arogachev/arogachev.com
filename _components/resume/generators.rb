require 'jekyll'
require 'liquid'

module Resume
  class DataGenerator
    def initialize(input_folder, output_file)
      @input_folder = input_folder
      @output_file = output_file
    end

    def generate
      site = Jekyll::Site.new(Jekyll.configuration)
      data = {}
      Jekyll::DataReader.new(site).read_data_to(@input_folder, data)
      data = Decorator.new(data).decorate
      File.open(@output_file, 'w') {|f| f.write data.to_yaml }
    end
  end

  class TemplateConverter
    def initialize(input_file, data_file, output_file)
      @input_file = input_file
      @data_file = data_file
      @output_file = output_file
    end

    def convert
      input_content = File.read(@input_file).encode(universal_newline: true).gsub("%}\n", '%}')
      data = YAML.load_file(@data_file)
      template = Liquid::Template.parse(input_content)
      content = template.render(data, filters: [TextFilter])
      content = content.gsub(/\n{3,}/, "\n\n").gsub("\n ", ' ').gsub(/ {2,}/, ' ').strip
      content << "\n"
      File.open(@output_file, 'w') {|f| f.write(content) }
    end
  end

  module TextFilter
    def sentence(input)
      input.join(', ')
    end

    def brief(input)
      sentences = input.split('. ')
      sentence = sentences.first
      sentence << '.' if sentences.length > 1
      sentence
    end

    def profile_link(input)
      "[#{input['network']} (#{input['username']})](#{input['url']})"
    end
  end
end
