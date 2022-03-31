class Feature < ApplicationRecord
  belongs_to :project
  enum status: [:created, :in_progress, :in_review, :complete]
end
