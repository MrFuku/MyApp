
class DevisePreview < ActionMailer::Preview

  # Preview http://localhost:3000/rails/mailers/devise/confirmation_instructions
  def confirmation_instructions
    user = User.new(name:"jack", email: "jack@example.com")
    Devise::Mailer.confirmation_instructions(user, Devise.friendly_token[0,20])
  end

  # Preview http://localhost:3000/rails/mailers/devise/reset_password_instructions
  def reset_password_instructions
    user = User.new(name:"jack", email: "jack@example.com")
    Devise::Mailer.reset_password_instructions(user, Devise.friendly_token[0,20])
  end
end
