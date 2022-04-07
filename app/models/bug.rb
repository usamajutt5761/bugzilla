# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  enum status: { created: 0, in_progress: 1, in_review: 2, fixed: 3 }
end
