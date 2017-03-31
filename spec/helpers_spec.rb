require 'helper'
require 'date'
include Components::Helpers

RSpec.describe StringHelper do
  describe '.pluralize' do
    context 'with singular noun' do
      it 'does not add ending' do
        expect(StringHelper.pluralize(1, 'year')).to eq('1 year')
      end
    end

    context 'with plural noun' do
      it 'adds ending' do
        # Zero is considered plural towards noun
        expect(StringHelper.pluralize(0, 'year')).to eq('0 years')
        expect(StringHelper.pluralize(2, 'year')).to eq('2 years')
        expect(StringHelper.pluralize(5, 'year')).to eq('5 years')
        expect(StringHelper.pluralize(10, 'year')).to eq('10 years')
      end
    end

    context 'with pluran noun, custom form' do
      it 'adds ending according to custom form' do
        expect(StringHelper.pluralize(2, 'potato', 'potatoes')).to eq('2 potatoes')
      end
    end
  end

  describe '.humanize' do
    it 'returns human readable form of a string' do
      expect(StringHelper.humanize('products_category_page')).to eq('Products category page')
    end
  end

  describe '.string_between_markers' do
    context 'with 2 different markers, no occurences' do
      it 'returns nothing' do
        expect(StringHelper.string_between_markers('... content ...', '<<', '>>')).to be_nil
      end
    end

    context 'with 2 different markers, 1 occurence for each' do
      it 'returns string in between them' do
        expect(StringHelper.string_between_markers('... start content end ...', 'start', 'end')).to eq(' content ')
      end
    end

    context 'with 2 different markers, multiple occurences for each' do
      it 'returns string between first found pair' do
        test_string = '... start content1 end start content2 end ...'
        expect(StringHelper.string_between_markers(test_string, 'start', 'end')).to eq(' content1 ')
      end
    end

    context 'with 1 marker, multiple occurences' do
      it 'returns string between first found pair' do
        test_string = '... marker content1 marker marker content2 marker ...'
        expect(StringHelper.string_between_markers(test_string, 'marker')).to eq(' content1 ')
      end
    end

    context 'with 2 identical string markers, multiple occurences' do
      it 'returns string between first found pair' do
        test_string = '... marker content1 marker marker content2 marker ...'
        expect(StringHelper.string_between_markers(test_string, 'marker', 'marker')).to eq(' content1 ')
      end
    end

    context 'with 2 identical regexp markers, multiple occurences' do
      it 'returns string between first found pair' do
        test_string = '... <hr> content1 <hr /> <hr> content2 <hr /> ...'
        marker = /<hr ?\/?>/
        expect(StringHelper.string_between_markers(test_string, marker, marker)).to eq(' content1 ')
      end
    end
  end
end

RSpec.describe StringHelper do
  describe '.work_duration' do
    context 'with months' do
      context 'with last month less than a half' do
        it 'returns according message' do
          duration = 'less than a month'
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-08-20'))).to eq(duration)
        end
      end

      context 'last month more than a half' do
        it 'rounds up to 1 month' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-05'))).to eq('1 month')
        end
      end

      context 'last full month' do
        it 'counts last month as 1' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-15'))).to eq('1 month')
        end
      end

      context 'last month less than a half' do
        it 'rounds down to 1 month' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-20'))).to eq('1 month')
        end
      end
    end

    context 'with years' do
      context 'with last month less than a half' do
        it 'rounds down to 1 month and shows years only' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-20'))).to eq('1 year')
        end
      end

      context 'with no extra days' do
        it 'shows years only' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-15'))).to eq('1 year')
        end
      end

      context 'with last month more than a half' do
        it 'rounds up to 1 month and shows years only' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-05'))).to eq('1 year')
        end
      end
    end

    context 'with years and months' do
      context 'with last month more than a half' do
        it 'rounds up to 1 month and shows both years and months' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-05'))).to eq('1 year 1 month')
        end
      end

      context 'with last full month' do
        it 'counts last month as 1 and shows both years and months' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-15'))).to eq('1 year 1 month')
        end
      end

      context 'with last month less than a half' do
        it 'rounds down to 1 month and shows both years and months' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-20'))).to eq('1 year 1 month')
        end
      end
    end

    context 'with plural nouns' do
      it 'shows correct names' do
        expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2017-01-04'))).to eq('5 years 5 months')
      end
    end

    context 'with no end date' do
      it 'returns duration from start date to current date' do
        allow(DateTime).to receive(:now).and_return(DateTime.new(2017, 1, 4))
        expect(DateHelper.work_duration(Date.parse('2011-08-15'))).to eq('5 years 5 months')
      end
    end
  end

  describe '.age' do
    context 'with more than month before birthday' do
      it 'does not round age' do
        allow(Time).to receive(:now).and_return(Time.mktime(2017, 1, 7))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(26)
      end
    end

    context 'with less than month before birthday' do
      it 'does not round age' do
        allow(Time).to receive(:now).and_return(Time.mktime(2017, 2, 7))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(26)
      end
    end

    context 'with birthday' do
      it 'shows new age' do
        allow(Time).to receive(:now).and_return(Time.mktime(2017, 2, 17))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(27)
      end
    end

    context 'with less than month after birthday' do
      it 'does not round age' do
        allow(Time).to receive(:now).and_return(Time.mktime(2017, 3, 7))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(27)
      end
    end

    context 'with leap years' do
      context 'with birthday' do
        it 'shows new age' do
          allow(Time).to receive(:now).and_return(Time.mktime(2016, 2, 29))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(16)
        end
      end

      context 'with not leap year, day before birthday' do
        it 'does not round age' do
          allow(Time).to receive(:now).and_return(Time.mktime(2015, 2, 28))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(14)
        end
      end

      context 'with not leap year, day after birthday' do
        it 'shows new age' do
          allow(Time).to receive(:now).and_return(Time.mktime(2015, 3, 1))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(15)
        end
      end
    end
  end
end
