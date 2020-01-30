class Journey

    attr_reader :entry_station, :exit_station, :journeys

    def initialize
        @entry_station
        @exit_station
        @journeys = []
    end

    def set_entry_station(station)
        @entry_station = station
    end

    def set_exit_station(station)
        @exit_station = station
    end

    def store_journey
        @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    end

end
