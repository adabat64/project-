class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, dependent: :destroy
end
