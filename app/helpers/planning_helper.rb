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

end
