# frozen_string_literal: true

class UserToProject < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
