# frozen_string_literal: true

class AdminUser < ApplicationRecord
  enum role: { project_manager: 0, developer: 1, qa: 2, admin: 3 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
