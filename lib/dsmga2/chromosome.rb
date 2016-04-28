# Each instance of the class represent an individual.
class DSMGA2::Chromosome
  attr_reader :value, :genes, :length
  # A Fixnum or a DSMGA2::Chromosome can be passed into.
  # The former create a new Chromosome with length param['item'].
  # The latter deep_clone the item.
  def initialize(item)
    case item 
    when Fixnum
      @length = item
      @genes = Array.new(@length){yield}
      @value = fitness
    when DSMGA2::Chromosome
      deep_clone(item)
    end
  end
  # Clone the length, genes, and value of the given chromo.
  def deep_clone(chromo)
    @length = chromo.length
    @genes = chromo.genes
    @value = chromo.value
  end
  # Change the genes of the range to the value of given input_array.
  # Raises IndexError if range.size is not input_array.size 
  def change(range, input_array)
    # raise IndexError if range.size != input_array.size
    # TODO: Make it raise error while not harming other methods.
    range.each do |i|
      @genes[i] = input_array[i-range.begin]
    end
    @value = fitness
  end

  # Bitwise flip and take if the fitness value increase, time-complexity is O(length)
  def local_search
    (0...@genes.length).each do |i|
      tmp = self.class.new(self.itself)
      tmp.change((i..i), 1-@genes[i])
      deep_clone(tmp) if tmp.value > self.value
    end
  end
  # The fitness function, which is a private function.
  def fitness
    0
  end

  private :fitness
end