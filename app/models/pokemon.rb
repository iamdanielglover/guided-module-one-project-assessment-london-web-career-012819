class Pokemon < ActiveRecord::Base
  has_many :battles
  has_one :trainer, through: :battles
end
