module Mutations
  module ClassAdviser
    class ClassAdviserUpdateMutation < Mutations::BaseMutation
      argument :id, String, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :cellphone, String, required: true
      argument :branch_schools, [String], required: true

      field :class_advisers, [Types::ClassAdviserType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(id:, name:, email:, branch_schools:, **profile_attributes)
        class_adviser = ::ClassAdviser.find(id)
        update_class_adviser(class_adviser, name, email, branch_schools, profile_attributes)
        { success: true, class_advisers: ::ClassAdviser.includes(:profile, :branch_schools) }
      rescue ActiveRecord::RecordNotFound => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, message: e.record.errors.full_messages.join('、 ') }
      end

      private

      def update_class_adviser(class_adviser, name, email, branch_schools, profile_attributes)
        ::ClassAdviser.transaction do
          class_adviser.assign_attributes(name: name, email: email)
          class_adviser.profile.assign_attributes(profile_attributes)
          class_adviser.branch_schools = BranchSchool.where(name: branch_schools)
          class_adviser.save!
        end
      end
    end
  end
end
