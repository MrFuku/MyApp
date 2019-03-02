class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
   validates :name,  presence: true, length: { maximum: 50 }
   validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: true
end