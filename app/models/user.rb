class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :trackable, :lockable

  has_many :downloads, dependent: :nullify
end
