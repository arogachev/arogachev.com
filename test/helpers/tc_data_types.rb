require 'date'
require 'test/unit'
require 'mocha/test_unit'
require 'helpers/data_types'
include Components::Helpers

class TestStringHelper < Test::Unit::TestCase
  def test_pluralize
    # Singular noun
    assert_equal('1 year', StringHelper.pluralize(1, 'year'))

    # Plural noun
    assert_equal('0 years', StringHelper.pluralize(0, 'year'))
    assert_equal('2 years', StringHelper.pluralize(2, 'year'))
    assert_equal('5 years', StringHelper.pluralize(5, 'year'))

    # Plural noun, custom form
    assert_equal('2 potatoes', StringHelper.pluralize(2, 'potato', 'potatoes'))
  end

  def test_humanize
    assert_equal('Products category page', StringHelper.humanize('products_category_page'))
  end

  def test_string_between_markers
    marker_start = 'start'
    marker_end = 'end'

    test_string = '... content ...'
    assert_equal(nil, StringHelper.string_between_markers(test_string, marker_start, marker_end))

    test_string = '... start content end ...'
    assert_equal(' content ', StringHelper.string_between_markers(test_string, marker_start, marker_end))

    test_string = '... start content1 end start content2 end ...'
    assert_equal(' content1 ', StringHelper.string_between_markers(test_string, marker_start, marker_end))

    test_string = '... marker content1 marker marker content2 marker ...'
    assert_equal(' content1 ', StringHelper.string_between_markers(test_string, 'marker', 'marker'))
  end
end

class TestDateHelper < Test::Unit::TestCase
  def test_work_duration
    assert_equal('less than a month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-08-20')))

    assert_equal('1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-05')))
    assert_equal('1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-15')))
    assert_equal('1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2011-09-20')))

    assert_equal('1 year', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-05')))
    assert_equal('1 year', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-15')))
    assert_equal('1 year', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-08-20')))

    assert_equal('1 year 1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-05')))
    assert_equal('1 year 1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-15')))
    assert_equal('1 year 1 month', DateHelper.work_duration(Date.parse('2011-08-15'), Date.parse('2012-09-20')))

    DateTime.stubs(:now).returns(DateTime.new(2017, 1, 4))
    assert_equal('5 years 5 months', DateHelper.work_duration(Date.parse('2011-08-15')))
  end

  def test_age
    Time.stubs(:now).returns(Time.mktime(2017, 1, 7))
    assert_equal(26, DateHelper.age(Date.parse('1990-02-17')))

    Time.stubs(:now).returns(Time.mktime(2017, 2, 7))
    assert_equal(26, DateHelper.age(Date.parse('1990-02-17')))

    Time.stubs(:now).returns(Time.mktime(2017, 2, 17))
    assert_equal(27, DateHelper.age(Date.parse('1990-02-17')))

    Time.stubs(:now).returns(Time.mktime(2017, 3, 7))
    assert_equal(27, DateHelper.age(Date.parse('1990-02-17')))

    # Leap year
    Time.stubs(:now).returns(Time.mktime(2016, 2, 29))
    assert_equal(16, DateHelper.age(Date.parse('2000-02-29')))

    Time.stubs(:now).returns(Time.mktime(2015, 2, 28))
    assert_equal(14, DateHelper.age(Date.parse('2000-02-29')))

    Time.stubs(:now).returns(Time.mktime(2015, 3, 1))
    assert_equal(15, DateHelper.age(Date.parse('2000-02-29')))
  end
end
