require_relative 'action'

class InputHandler
    attr_accessor :robot, :table, :action

    PLACE   = /^PLACE\s+\d+\s*,\s*\d+\s*,\s*(WEST||NORTH||EAST||SOUTH)$/
    ACTIONS = %w[MOVE LEFT RIGHT REPORT].freeze

    def initialize(robot, table, action)
        @robot = robot
        @table = table
        @action = action
    end

    def interpret(command)
        return unless command.match(PLACE) || ACTIONS.include?(command)

        return exec(action.place(command)) if command.match?(PLACE)
        return if robot.not_in_place?

        exec(next_position(robot.position, command))
    end

    private

  def next_position(position, command)
    action.public_send ACTIONS.detect { |e| e == command }.downcase, position
  end

  def exec(position)
    return unless table.valid_position?(position)

    robot.update_robot(position)
  end
end


