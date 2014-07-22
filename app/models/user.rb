class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wall_roles
  has_many :walls, through: :wall_roles
  has_many :images, through: :walls

  def name
    email.split('@').first
  end
end
