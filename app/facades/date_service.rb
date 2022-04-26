class DateService
  def self.upcoming_holidays
    response = HTTParty.get('https://date.nager.at/api/v3/nextpublicholidays/us')
    data = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
  end
end
