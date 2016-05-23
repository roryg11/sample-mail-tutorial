class User < ActiveRecord::Base
  has_secure_password

  has_many :memberships
  has_many :user_groups, through: :memberships

  has_many :invitations, :class_name => 'Invite'
  has_many :sent_invites, :class_name => 'Invite'
end
