class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable,# :registerable,
          :recoverable, :rememberable, :trackable, :validatable
#          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_and_belongs_to_many :roles   

  def role?(role)
    return !!self.roles.find_by_name(role)
  end
end
