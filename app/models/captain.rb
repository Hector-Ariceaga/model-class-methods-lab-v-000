class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    Captain.joins(boats: :classifications).select(classifications: {name: "Motorboat"}).where(:id => self.sailors.pluck(:id)).uniq
  end

  def self.non_sailors
    Captain.where.not(:id => self.sailors.pluck(:id))
  end
end
