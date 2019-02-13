class Trainer < ActiveRecord::Base
  belongs_to :pokemon
  has_many :battles
end
