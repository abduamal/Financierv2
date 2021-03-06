class User < ApplicationRecord
    has_many :accounts, dependent: :destroy
    has_many :transactions, through: :accounts
    has_many :payments, through: :accounts

    has_secure_password
    validates :first_name, :last_name, :email, presence: true
    validates :email, :uniqueness =>  true

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
          user.password = SecureRandom.hex
        end
    end
end
