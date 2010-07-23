module ItemHelper
  def default_dates
    return flash[:dates] if flash[:dates]
    [ @date.strftime('%d/%m/%Y'), hour(+0), hour(+1) ].join(' ')
  end

  def hour(hdelta)
    t = Time.now + (hdelta*3600)
    q = ((t.min / 60.0) * 4).ceil / 4.0 * 60
    hour = (q == 60 ? t.hour + 1 : t.hour).round
    min  = (q == 60 ? 0          : q     ).round
    "%02d:%02d" % [hour, min]
  end
end
