class Project < ApplicationRecord
  has_many :bugs, dependent: :destroy
  has_many :features, dependent: :destroy
  has_many :user_to_projects, dependent: :destroy
  has_many :users, through: :user_to_projects
end
