module ApplicationHelper
  include Pagy::Frontend

  def format_datetime(time)
    time.strftime("%F %T")
  end
end
