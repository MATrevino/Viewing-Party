class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :password, presence: true

  has_secure_password

  enum role: ["logged_out", "logged_in"]
end