class BranchSchoolRelation < ApplicationRecord
  belongs_to :user
  belongs_to :branch_school
end
