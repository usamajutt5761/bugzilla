# frozen_string_literal: true

class Feature < ApplicationRecord
  belongs_to :project
  enum status: { created: 0, in_progress: 1, in_review: 2, complete: 3 }
end
