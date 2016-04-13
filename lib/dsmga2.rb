##
# The main class of the gem, whose algorithm intends to find a global optimal
# of a given function.
class DSMGA2
  # An array of DSMGA2::Chromosome.
  attr_accessor :population

  ##
  # Initialize the population with the given size.
  def initialize(size_of_population = 27)
    @population = Array.new(size_of_population) {|p| DSMGA2::Chromosome.new}
    @population.each {|p| p = p.local_search}
  end
  
  ##
  # Return a DSMGA2::Chromosome with the greatest fitness.
  # pressure::
  #   The selection pressure for the tournament selection in building the DSM.
  # execute_round::
  #   The executing round for every generation.
  def run(pressure = 2, execute_round = 100)
    until self.termination_criteria_meet do
      # selected_population = DSMGA2::Selection.tournament(population, pressure)
      # matrix = DSMGA2::DSM.new(selected_population)
      matrix = DSMGA2::DSM.new(
        DSMGA2::Selection.tournament(@population, pressure)
      )
      execute_round.times do 
        linkage_set = DSMGA2::ILS.new(matrix)
        @population.shuffle.each do |p|
          p, linkage_set = DSMGA2::Mixing.restrict(p)
          p = DSMGA2::Mixing.back(p, linkage_set)
        end
      end
    end
    return @population.max_by {|p| p.fitness}
  end

  ##
  # Return a boolean whether the termination criteria meet or not.
  def termination_criteria_meet 
    true
  end

end

require 'dsmga2/chromosome'