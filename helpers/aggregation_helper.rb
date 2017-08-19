# helper module for aggregating data
module AggregationHelper
  ONE_MINUTE = 60
  ONE_HOUR = ONE_MINUTE * 60
  ONE_DAY = ONE_HOUR * 24
  ONE_WEEK = ONE_DAY * 7

  def group_records_by_week(records)
    first_record_created = records.order(:created_at).first[:created_at]
    first_weekday = first_record_created.wday
    start_of_records = first_record_created - ((first_weekday - 1) * ONE_DAY)
    last_record_created = records.order(:created_at).last[:created_at]
    last_weekday = last_record_created.wday
    end_of_records = last_record_created + (ONE_WEEK - (last_weekday * ONE_DAY))
    number_of_weeks = ((end_of_records - start_of_records) / ONE_WEEK).ceil
    weeks = []
    number_of_weeks.times do |index|
      weeks << records.map do |record|
        start = start_of_records + (ONE_WEEK * index - 1)
        ending = start + (ONE_WEEK - 1)
        record if (start.to_i..ending.to_i).cover? record[:created_at].to_i
      end.reject(&:nil?)
    end
    weeks
  end

  def group_records_by_day(records)
  end

  def average_run_time(records); end

  def count_passing(records); end

  def average_total_run_time(records); end
end


# require 'sequel'
# DB = Sequel.connect('postgres://postgres@localhost:5432/test_reports')
# require './helpers/aggregation_helper.rb'
# AggregationHelper.group_records_by_week(DB[:first_runs])
