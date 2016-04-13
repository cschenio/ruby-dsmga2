require 'minitest/autorun'
require 'dsmga2'

class TestDsmga2 < Minitest::Test

  def test_population_is_default
    @ga = Dsmga2.new
    assert_equal 27, @ga.population.size
    @ga = Dsmga2.new(13)
    refute_equal 27, @ga.population.size
    assert_equal 13, @ga.population.size
  end
end