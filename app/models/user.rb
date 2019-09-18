# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  before_save :downcase_email
  has_secure_password
  has_many :articles

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/

  def downcase_email
    self.email = email.delete(' ').downcase
  end
end
