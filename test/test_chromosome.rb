require 'minitest/autorun'
require 'dsmga2'

class TestChromosome < Minitest::Test
  module OneMax
    class Chromosome < DSMGA2::Chromosome
      private def fitness
        self.genes.reduce(0){|sum, i| sum += i}
      end
    end
  end
  module HalfHalf
    class Chromosome < DSMGA2::Chromosome
      private def fitness
        sum = 0
        (0...14).each {|i| sum += self.genes[i]}
        (14...self.length).each {|i| sum += 1-self.genes[i]}
        sum
      end
    end
  end

  def setup
    @chromo_1 = OneMax::Chromosome.new(27){1}
    @chromo_2 = OneMax::Chromosome.new(27){0}
    @chromo_3 = HalfHalf::Chromosome.new(27){1}
    @chromo_4 = HalfHalf::Chromosome.new(27){0}
    @chromo_5 = DSMGA2::Chromosome.new(@chromo_1)
    @chromo_6 = OneMax::Chromosome.new(10){0}
    @chromo_7 = OneMax::Chromosome.new(10){0}
    @chromo_8 = OneMax::Chromosome.new(10){0}
  end

  def test_chromosome_constructor_and_fitness
    assert_equal 27, @chromo_1.value
    assert_equal 0,  @chromo_2.value
    assert_equal 14, @chromo_3.value
    assert_equal 13, @chromo_4.value
    assert_equal 27, @chromo_5.value
  end

  def test_fitness_is_private
    assert_raises NoMethodError do
      @chromo_1.fitness
    end
  end

  def test_chromosome_change
    assert_equal 0, @chromo_6.value
    @chromo_6.change((0...5),Array.new(5){1})
    assert_equal 5, @chromo_6.value
  end

  def test_chromosome_local_search
    assert_equal 0,  @chromo_7.value
    @chromo_7.local_search
    assert_equal 10, @chromo_7.value
  end

  def test_deep_clone
    tmp = OneMax::Chromosome.new(10){1}
    assert_equal 10, tmp.value
    tmp.deep_clone(@chromo_8)
    assert_equal 0, tmp.value
    refute_equal tmp, @chrome_8 
  end
end