class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :read, :update, :destroy, :to => :rud

    #special case for example wall
    can [:show, :frame], Wall do |wall|
      wall.id == Wall.example.id if Wall.example
    end

    if user.is_admin?
      can :manage, :all
    end

    unless user.id.nil?
      can [:create], Wall
      can [:rud, :frame, :control, :remove_background, :remove_logo], Wall do |wall|
        user.walls.pluck(:id).include? wall.id
      end
      can [:approve, :ban], Item do |item|
        user.items.pluck(:id).include? item.id
      end
      # can [:create], Item do |wall|
      #   user.walls.pluck(:id).include? wall.id
      # end
    end
  end
end
