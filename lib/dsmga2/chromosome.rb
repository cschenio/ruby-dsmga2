class DSMGA2::Chromosome
  attr_reader :value, :genes, :length

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
  
  def deep_clone(item)
    @length = item.length
    @genes = item.genes
    @value = item.value
  end

  def change(range, input)
    range.each do |i|
      @genes[i] = input[i-range.begin]
    end
    @value = fitness
  end

  def local_search
    (0...@genes.length).each do |i|
      tmp = self.class.new(self.itself)
      tmp.change((i..i), 1-@genes[i])
      deep_clone(tmp) if tmp.value > self.value
    end
  end
  
  def fitness
    0
  end

  private :fitness
end