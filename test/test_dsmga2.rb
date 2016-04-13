require 'minitest/autorun'
require 'dsmga2'

class TestDsmga2 < Minitest::Test

  def setup
    @ga_1 = Dsmga2.new
    @ga_2 = Dsmga2.new(13)
  end

  def test_population_initialization
    assert_equal 27, @ga_1.population.size

    refute_equal 27, @ga_2.population.size
    assert_equal 13, @ga_2.population.size
  end

end