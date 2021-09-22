class User < ActiveRecord::Base
    has_many :plants
    validates_presence_of :name, :email, :address, :password_digest
    has_secure_password
end