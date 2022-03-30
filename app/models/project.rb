class Project < ApplicationRecord
  has_many :user_to_projects
  has_many :users, through: :user_to_projects
end
