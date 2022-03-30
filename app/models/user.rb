class User < ApplicationRecord

  has_many :user_to_projects
  has_many :projects, through: :user_to_projects
  enum role: [:project_manager, :developer, :qa]

  validates :role, presence: :true
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_one_attached :avatar 
  # # do |attachable|
  # #   attachable.variant :thumb, resize_to_limit: [100, 100]
  # # end
  
  # #  :add_default_avatar  on: %i[create update]

  # def avatar_thumbnail
  #   if avatar.attached?
  #       avatar.variant(resize: "100x100!")
  #   else 
  #     after_commit "/default_profile.jpg"
  #   end
  # end  


  private

  # def add_default_avatar
  #   unlesss avatar.attached?
  #    avatar.attach(
  #      io: File.open(
  #        Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')
  #       )
  #       , filename: 'deault_profile.jpg', content_type: 'image/jpg')
  #   end
  # end 
end
