class Contributor
  attr_reader :name, :contributions

  def initialize(data)
    @name = data[:name]
    @login = data[:login]
  end
end
