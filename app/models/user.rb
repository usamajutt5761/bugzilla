# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bugs, dependent: :nullify
  has_many :user_to_projects, dependent: :destroy
  has_many :projects, through: :user_to_projects
  enum role: { project_manager: 0, developer: 1, qa: 2, admin: 3 }

  validates :role, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  ## Validations
  validates :avatar, file_size:         { less_than_or_equal_to: 5.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
end
