require_relative 'position'

class Robot
    attr_reader :position

    def initialize
        @position = nil
    end

    def update_robot(new_position)
        @position = new_position
    end

    def not_in_place?
        @position.nil?
    end
end