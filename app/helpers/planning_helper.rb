# -*- coding: utf-8 -*-
module PlanningHelper

  def week_day
    ["Dimanche",
     "Lundi",
     "Mardi",
     "Mercredi",
     "Jeudi",
     "Vendredi",
     "Samedi"
    ]
  end

  def months
    ["Months",
     "Janvier",
     "Février",
     "Mars",
     "Avril",
     "Mai",
     "Juin",
     "Juillet",
     "Août",
     "Septembre",
     "Octobre",
     "Novembre",
     "Décembre"
    ]
  end

  def serialize_date(time)
    "#{time.day}/#{time.month}/#{time.year}"
  end

  def display_date(time)
    "#{week_day[time.wday]} #{time.day} #{months[time.month]} #{time.year}"
  end

  def get_time(date = params[:date])
    if !date.nil?
      begin
        if date.include?("/")
          tab = date.split('/')
          time = "#{tab[2]}-#{tab[1]}-#{tab[0]} 00:00:00".to_time
        else
          tab = date.split('-')
          time = "#{tab[0]}-#{tab[1]}-#{tab[2]} 00:00:00".to_time
        end
      rescue
        time = Time.new
      end
    else
      time = Time.new
    end
    return time
  end

  def get_first_day_of_week(time = get_time)
    while time.wday != 1
      time -= 86400
    end
    return time
  end

  def get_first_day_of_month(time = get_time)
    while time.day > 1
      time -= 86400
    end
    return time
  end

  def is_full_day?(day)
    tasks = Task.where("date = '#{serialize_date(day)}'").all
    tasks.each do |task|
      return false if task.need > task.count_assigned
    end
    return true
  end

  def get_week_infos(day)
    days = []
    7.times.each do
      tmp = {}
      tmp[:display_date] = display_date(day)
      tmp[:serialized_date] = serialize_date(day)
      tmp[:day] = day.day
      tmp[:month] = day.month
      tmp[:full] = is_full_day?(day)
      tmp[:work] = current_user.jobs.where("date = '#{serialize_date(day)}'").all.count > 0 ? true : false
      days << tmp
      day += 86400
    end
    return days
  end

end
