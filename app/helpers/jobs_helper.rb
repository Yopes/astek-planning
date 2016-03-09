# -*- coding: utf-8 -*-
module JobsHelper

  def week_day
    ["Week Day",
     "Lundi",
     "Mardi",
     "Mercredi",
     "Jeudi",
     "Vendredi",
     "Samedi",
     "Dimanche"
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

end
