# -*- coding: utf-8 -*-
module CsvExtractorHelper

  require 'csv'

  def csv_display_date(time)
    date = "#{week_day[time.wday]} " +
      "#{time.day < 10 ? '0' : ''}#{time.day}/" +
      "#{time.month < 10 ? '0' : ''}#{time.month}/#{time.year}"
  end

  def get_last_planning_day
    job = Job.order('date DESC').first
    job = job.date if !job.nil?
    task = Task.order('date DESC').first
    task = task.date if !task.nil?
    return job if task.nil?
    return task if job.nil?
    task > job ? task : job
  end

  def get_csv_header
    header = ["", "ACTIVITES", "BESOIN", "ASSIGNÉS"]
    User.where("actif = true").each do |user|
      header << user.login
    end
    return header
  end

  def get_csv_total
    total = ["Nombre de jours à faire en tout =>", "", "", ""]
    User.where("actif = true").each do |user|
      total << user.total_days
    end
    return total
  end

  def get_csv_worked
    worked = ["Nombre de jours travaillés (et placés) =>", "", "", ""]
    User.where("actif = true").each do |user|
      worked << user.count_past_days
    end
    return worked
  end

  def get_csv_todo
    todo = ["Nombre de jours restants à placer sur le planning =>", "", "", ""]
    User.where("actif = true").each do |user|
      todo << user.total_days - user.count_past_days
    end
    return todo
  end

  def get_csv_days(day)
    days = []
    last_day = get_last_planning_day
    while !last_day.nil? && day <= last_day
      days << [csv_display_date(day)]
      day += 86400
    end
    return days
  end

  def csv(day)    
    CSV.generate do |csv|
      csv << get_csv_header
      csv << get_csv_total
      csv << get_csv_worked
      csv << get_csv_todo
      get_csv_days(day).each do |d|
        csv << d
      end
    end
  end
end
