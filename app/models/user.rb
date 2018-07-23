class User < ApplicationRecord
  has_secure_password

  has_many :uploads

  validates_uniqueness_of :username
  validates_uniqueness_of :email

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :phone, :presence => true, :numericality => true

  validates_presence_of :username, :email, :password
end
