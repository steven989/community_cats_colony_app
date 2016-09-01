class UserToken < ActiveRecord::Base
    scope :admins, -> { where(role: 'admin') }

    def self.create_token(email,role)
        token = UserToken.create(email:email,token:SecureRandom.urlsafe_base64,role:role)
        token
    end

    def self.find_by_token(token)
        match = UserToken.where(token:token)
        if match.length == 1
            match.take
        else
            UserToken.where(token:token).destroy_all
            nil
        end
    end
end
