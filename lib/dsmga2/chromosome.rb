class DSMGA2::Chromosome
  attr_reader :value, :genes, :length

  def initialize(item)
    case item 
    when Fixnum
      @length = item
      @genes = Array.new(@length){yield}
      @value = fitness
    when DSMGA2::Chromosome
      @length = item.length
      @genes = item.genes
      @value = item.value
    end
  end

  def change(range, input)
    range.each do |i|
      @genes[i] = input[i-range.begin]
    end
    @value = fitness
  end

  def local_search

  end
  
  def fitness
    0
  end

  private :fitness
end