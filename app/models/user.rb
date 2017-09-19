class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  # only returns user's name if that exists, otherwise returns user's email
  def get_name
    if self.name.nil? || self.name.empty?
      self.email
    else
      self.name
    end
  end
end
