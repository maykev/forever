class Invitee < ActiveRecord::Base
  belongs_to :invitation

  validates_presence_of :name
end
