require 'minitest/autorun'
require 'dsmga2'

class TestDSMGA2 < Minitest::Test

  def setup
    @ga_1 = DSMGA2.new
    @ga_2 = DSMGA2.new(13)
    @best_chromosome = @ga_1.run
  end

  def test_population_initialization
    assert_equal 27, @ga_1.population.size

    refute_equal 27, @ga_2.population.size
    assert_equal 13, @ga_2.population.size
  end

  def test_outcome_of_run
    assert_equal 0, @best_chromosome.value
    refute_equal 1, @best_chromosome.value
  end

end