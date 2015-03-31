module DateHelper
  def format_date(date, format=:short)
    if date.present?
      l(date, format: format)
    else
      "No Date"
    end
  end
end
