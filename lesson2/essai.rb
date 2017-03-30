class Obj
  
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end
  
  def name=(name)
    @name = name
  end
  
end

a = Obj.new

class Nal
  def self.wala
    a
  end
end