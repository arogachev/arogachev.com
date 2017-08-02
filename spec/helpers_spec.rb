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
        it 'rounds down to 1 month' do
          duration = {years: 0, months: 0}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-08-20'))).to eq(duration)
        end
      end

      context 'last month more than a half' do
        it 'rounds up to 1 month' do
          duration = {years: 0, months: 1}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-05'))).to eq(duration)
        end
      end

      context 'last full month' do
        it 'counts last month as 1' do
          duration = {years: 0, months: 1}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-15'))).to eq(duration)
        end
      end

      context 'last month less than a half' do
        it 'rounds down to 1 month' do
          duration = {years: 0, months: 1}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-20'))).to eq(duration)
        end
      end
    end

    context 'with years' do
      context 'with last month less than a half' do
        it 'rounds down to 1 month and shows years only' do
          duration = {years: 1, months: 0}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-20'))).to eq(duration)
        end
      end

      context 'with no extra days' do
        it 'shows years only' do
          duration = {years: 1, months: 0}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-15'))).to eq(duration)
        end
      end

      context 'with last month more than a half' do
        it 'rounds up to 1 month and shows years only' do
          duration = {years: 1, months: 0}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-05'))).to eq(duration)
        end
      end
    end

    context 'with years and months' do
      context 'with last month more than a half' do
        it 'rounds up to 1 month and shows both years and months' do
          duration = {years: 1, months: 1}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-05'))).to eq(duration)
        end
      end

      context 'with last full month' do
        it 'counts last month as 1 and shows both years and months' do
          duration = {years: 1, months: 1}
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-15'))).to eq(duration)
        end
      end

      context 'with last month less than a half' do
        duration = {years: 1, months: 1}
        it 'rounds down to 1 month and shows both years and months' do
          expect(DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-20'))).to eq(duration)
        end
      end
    end

    context 'with no end date' do
      it 'returns duration from start date to current date' do
        allow(DateTime).to receive(:now).and_return(DateTime.new(2017, 1, 4))
        duration = {years: 5, months: 5}
        expect(DateHelper.work_duration(Date.parse('2011-08-15'))).to eq(duration)
      end
    end

    context 'with years_only set' do
      context 'with months less than half of year' do
        it 'rounds down to 1 year' do
          duration = {years: 5, months: 0}
          result = DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2017-01-04'), years_only: true)
          expect(result).to eq(duration)
        end
      end

      context 'with months more than half of year' do
        it 'rounds up to 1 year' do
          duration = {years: 6, months: 0}
          result = DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2017-03-04'), years_only: true)
          expect(result).to eq(duration)
        end
      end
    end
  end

  describe '.work_duration_label' do
    context 'with duration less than a month' do
      it 'returns according label' do
        label = 'less than a month'
        expect(DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2011-08-20'))).to eq(label)
      end
    end

    context 'with duration less than a year' do
      it 'shows months only' do
        expect(DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2011-09-05'))).to eq('1 month')
      end
    end

    context 'with round years' do
      it 'shows years only' do
        expect(DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2012-08-20'))).to eq('1 year')
      end
    end

    context 'with not round years' do
      it 'shows years and months' do
        label = '5 years 5 months'
        expect(DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2017-01-04'))).to eq(label)
      end
    end

    context 'with years_only set' do
      context 'with months less than half of year' do
        it 'rounds down to 1 year' do
          label = '5 years'
          result = DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2017-01-04'), years_only: true)
          expect(result).to eq(label)
        end
      end

      context 'with months more than half of year' do
        it 'rounds up to 1 year' do
          label = '6 years'
          result = DateHelper.work_duration_label(Date.parse('2011-08-15'), Date.parse('2017-03-04'), years_only: true)
          expect(result).to eq(label)
        end
      end
    end
  end

  describe '.age' do
    context 'with more than month before birthday' do
      it 'does not round age' do
        allow(Date).to receive(:today).and_return(Date.parse('2017-01-07'))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(26)
      end
    end

    context 'with less than month before birthday' do
      it 'does not round age' do
        allow(Date).to receive(:today).and_return(Date.parse('2017-02-07'))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(26)
      end
    end

    context 'with birthday' do
      it 'shows new age' do
        allow(Date).to receive(:today).and_return(Date.parse('2017-02-17'))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(27)
      end
    end

    context 'with less than month after birthday' do
      it 'does not round age' do
        allow(Date).to receive(:today).and_return(Date.parse('2017-03-07'))
        expect(DateHelper.age(Date.parse('1990-02-17'))).to eq(27)
      end
    end

    context 'with leap years' do
      context 'with birthday' do
        it 'shows new age' do
          allow(Date).to receive(:today).and_return(Date.parse('2016-02-29'))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(16)
        end
      end

      context 'with not leap year, day before birthday' do
        it 'does not round age' do
          allow(Date).to receive(:today).and_return(Date.parse('2015-02-28'))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(14)
        end
      end

      context 'with not leap year, day after birthday' do
        it 'shows new age' do
          allow(Date).to receive(:today).and_return(Date.parse('2015-03-01'))
          expect(DateHelper.age(Date.parse('2000-02-29'))).to eq(15)
        end
      end
    end
  end
end
