class User < ActiveRecord::Base
  before_save   :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
