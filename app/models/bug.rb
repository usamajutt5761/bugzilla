class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  enum status: [:created, :in_progress, :in_review, :fixed]
end
