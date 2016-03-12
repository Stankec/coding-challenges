require 'set'

class InterrogationRoom
  attr_reader :interrogated_prisoners
  attr_reader :prisoner
  attr_reader :prison
  attr_accessor :lightbulb

  def initialize(prison)
    @prison = prison
    @interrogated_prisoners = Set.new
    @lightbulb = false
  end

  def prisoner=(prisoner)
    clear_prisoner!
    @prisoner = prisoner

    interrogated_prisoners.add(self.prisoner)
    self.prisoner.interrigation_room = self
  end

  def all_prisoners_visited?
    prison.prisoners.count == interrogated_prisoners.size
  end

  private

  def clear_prisoner!
    return unless prisoner
    prisoner.interrigation_room = nil
  end
end

class Prisoner
  attr_reader :prison
  attr_accessor :interrigation_room

  def initialize(prison)
    @prison = prison
  end

  def all_prisoners_visited_interrogation_room?
    false
  end
end

class Warden
  attr_reader :prison

  def initialize(prison)
    @prison = prison
  end

  def interrogate!
    prisoner = prison.prisoners.sample
    prison.interrigation_room.prisoner = prisoner
    prisoner.all_prisoners_visited_interrogation_room?
  end
end

class Prison
  attr_reader :interrigation_room
  attr_reader :warden
  attr_reader :prisoners

  def initialize(prisoner_count = 100)
    @interrigation_room = InterrogationRoom.new(self)
    @warden = Warden.new(self)
    @prisoners = []

    prisoner_count.times do
      prisoners << Prisoner.new(self)
    end

    yield(self) if block_given?
  end

  def start!
    while true do
      break if warden.interrogate!
    end

    if interrigation_room.all_prisoners_visited?
      puts "✅  The prisoners got set free"
    else
      puts "❌  All prisoners got executed"
    end
  end
end

#############################################
### START THE EXAMPLE AND PASS A STRATEGY ###
#############################################

Prison.new do |prison|
  prison.prisoners.each do |prisoner|
    def prisoner.toggled_light?
      !!@toggled_light
    end

    def prisoner.toggled_light=(toggled)
      @toggled_light = toggled
    end

    def prisoner.all_prisoners_visited_interrogation_room?
      if !interrigation_room.lightbulb && !toggled_light?
        interrigation_room.lightbulb = true
      end

      false
    end
  end

  leader = prison.prisoners.sample

  def leader.count
    @count ||= 0
  end

  def leader.count=(new_count)
    @count = new_count
  end

  def leader.all_prisoners_visited_interrogation_room?
    if interrigation_room.lightbulb
      interrigation_room.lightbulb = false
      self.count = count + 1
    end

    count == prison.prisoners.count - 1
  end
end.start!
