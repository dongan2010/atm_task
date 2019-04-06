class Banknote < ApplicationRecord

  validates :denomination, presence: true, inclusion: { in: [1,2,5,10,25,50] }

end
