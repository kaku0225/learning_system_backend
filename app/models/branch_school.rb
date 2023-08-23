class BranchSchool < ApplicationRecord
  has_many :branch_school_relations
  has_many :users, through: :branch_school_relations
end
