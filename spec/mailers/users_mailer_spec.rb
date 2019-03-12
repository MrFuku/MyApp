require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  describe "confirmations_mail" do
    let(:user) { create(:user, :non_active) }
    let(:mail) { Devise::Mailer.confirmation_instructions(user, Devise.friendly_token[0,20]) }

    it "送り先がユーザーのメールアドレスであること" do
      expect(mail.to).to eq [user.email]
    end

    it "サポート用のメールアドレスから送信すること" do
      expect(mail.from).to eq ["myapp@example.com"]
    end

    it "件名が正しいこと" do
      expect(mail.subject).to eq "Confirmation instructions"
    end

    it "ユーザーに対する挨拶文が含まれていること" do
      expect(mail.body).to match(/Welcome #{user.name}/)
    end
  end

  describe "reset_password_mail" do
    let(:user) { create(:user) }
    let(:mail) { Devise::Mailer.reset_password_instructions(user, Devise.friendly_token[0,20]) }

    it "送り先がユーザーのメールアドレスであること" do
      expect(mail.to).to eq [user.email]
    end

    it "サポート用のメールアドレスから送信すること" do
      expect(mail.from).to eq ["myapp@example.com"]
    end

    it "件名が正しいこと" do
      expect(mail.subject).to eq "Reset password instructions"
    end

    it "ユーザーに対する挨拶文が含まれていること" do
      expect(mail.body).to match(/Hello #{user.name}!/)
    end
  end
end
