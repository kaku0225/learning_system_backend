class ClassAdviserProfile < ApplicationRecord
  belongs_to :class_adviser, inverse_of: :profile
  validates :class_adviser, presence: true
end
