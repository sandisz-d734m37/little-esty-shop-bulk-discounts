class DateFacade
  def self.holiday
    DateService.upcoming_holidays.map do |hol|
      Holiday.new(hol)
    end
  end
end
