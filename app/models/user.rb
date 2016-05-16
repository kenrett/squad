class User < ActiveRecord::Base
  has_and_belongs_to_many :squads
  before_save   :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
