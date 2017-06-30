require 'helper'
require 'ostruct'
include Portfolio

RSpec.describe ProjectDecorator do
  describe '#decorate' do
    it 'decorates portfolio project page with new data' do
      page = OpenStruct.new
      page.name = '2016-2-zernovye-maslichnye-kazakhstan.md'
      page.data = {'screenshots' => ['home', 'agrarian_map']}

      ProjectDecorator.new(page).decorate
      expect(page.data).to eq({
        'permalink' => '/portfolio/projects/zernovye-maslichnye-kazakhstan/',
        'image' => '/assets/images/portfolio/projects/zernovye-maslichnye-kazakhstan/main.jpg',
        'screenshots' => [
          {'url' => '/assets/images/portfolio/projects/zernovye-maslichnye-kazakhstan/home.png', 'title' => 'Home'},
          {
              'url' => '/assets/images/portfolio/projects/zernovye-maslichnye-kazakhstan/agrarian_map.png',
              'title' => 'Agrarian map',
          },
        ],
      })
    end
  end
end