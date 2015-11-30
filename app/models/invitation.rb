class Invitation < ActiveRecord::Base
    has_many :invitees

    validates :email, presence: true
    validates :name, presence: true

    validates_uniqueness_of :email
end
