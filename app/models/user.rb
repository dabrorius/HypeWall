class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_destroy :delete_associated_walls
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wall_roles, dependent: :destroy
  has_many :walls, through: :wall_roles
  has_many :items, through: :walls


  def name
    email.split('@').first
  end

  def is_pro?
    subscription_level == 'pro'
  end

  private

    def delete_associated_walls
      Wall.where(id: walls.pluck(:id)).destroy_all
    end
end
