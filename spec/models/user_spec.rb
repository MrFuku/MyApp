require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "password"
    )
    @other_user = User.new(
      name: "Other User",
      email: "other@example.com",
      password: "password"
    )
  end

  context "有効なユーザー情報が入力されている時" do
    it "バリデーションが有効であること" do
      expect(@user).to be_valid
      expect(@other_user).to be_valid
    end
  end

  describe "ユーザー名に対する検証" do
    context "ユーザー名が入力されていない時" do
      it "バリデーションが無効であること" do
        @user.name = "    "
        expect(@user).to be_invalid
      end
    end

    describe "ユーザー名の長さ(上限50)" do
      context "長さが50の時" do
        it "バリデーションが有効であること" do
          @user.name = "a" * 50
          expect(@user).to be_valid
        end
      end

      context "長さが51の時" do
        it "バリデーションが無効であること" do
          @user.name = "a" * 51
          expect(@user).to be_invalid
        end
      end
    end
  end

  describe "メールアドレスに対する検証" do
    context "メールアドレスが入力されていない時" do
      it "バリデーションが無効であること" do
        @user.email = "    "
        expect(@user).to be_invalid
      end
    end

    describe "メールアドレスの長さ(上限255)" do
      context "長さが255の時" do
        it "バリデーションが有効であること" do
          @user.email = "a" * 243 + "@example.com"
          expect(@user).to be_valid
        end
      end

      context "長さが256の時" do
        it "バリデーションが無効であること" do
          @user.email = "a" * 244 + "@example.com"
          expect(@user).to be_invalid
        end
      end
    end

    context "有効なメールアドレスが入力された時" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        it "「#{valid_address}」は有効なメールアドレスである" do
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end

    context "無効なメールアドレスが入力された時" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com user@example..com]
      invalid_addresses.each do |invalid_address|
        it "「#{invalid_address}」は無効なメールアドレスである" do
          @user.email = invalid_address
          expect(@user).to be_invalid
        end
      end
    end

    describe "メールアドレスの一意性の確認" do
      it "同一のメールアドレスで登録できないこと" do
        @user.skip_confirmation!
        @user.save!
        @other_user.email = @user.email
        expect(@other_user).to be_invalid
      end

      it "大文字小文字を区別しないこと" do
        @user.skip_confirmation!
        @user.save!
        @other_user.email = @user.email.upcase
        expect(@other_user).to be_invalid
      end
    end
  end

  describe "パスワードに対する検証" do
    describe "パスワードの長さ(下限6)" do
      context "長さが6の時" do
        it "バリデーションが有効であること" do
          @user.password = "a" * 6
          expect(@user).to be_valid
        end
      end

      context "長さが5の時" do
        it "バリデーションが無効であること" do
          @user.password = "a" * 5
          expect(@user).to be_invalid
        end
      end
    end

    describe "パスワードの長さ(上限128)" do
      context "長さが128の時" do
        it "バリデーションが有効であること" do
          @user.password = "a" * 128
          expect(@user).to be_valid
        end
      end

      context "長さが129の時" do
        it "バリデーションが無効であること" do
          @user.password = "a" * 129
          expect(@user).to be_invalid
        end
      end
    end
  end
end
