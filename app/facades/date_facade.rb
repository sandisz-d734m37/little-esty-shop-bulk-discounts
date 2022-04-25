class DateFacade
  def upcoming_holidays
    response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/%2B1')
    binding.pry
    data = JSON.parse(response.body, symbolize_names: true)
  end
end
