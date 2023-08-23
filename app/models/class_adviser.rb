class ClassAdviser < User
  has_one :profile, class_name: 'ClassAdviserProfile', inverse_of: :class_adviser, dependent: :destroy, autosave: true
end
