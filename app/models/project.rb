class Project < ApplicationRecord
ApplicationRecordApplicationRecord  has_many :user_to_projects, dependent: :destroy
  has_many :users, through: :user_to_projects
end
