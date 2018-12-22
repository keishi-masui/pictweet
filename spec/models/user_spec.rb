require 'rails_helper'
describe User do
  describe '#create' do

# ・nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
  it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
  end

# ・nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      # user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "000000000")
      user = build(:user, nickname: "")
      user.vaild?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

# ・emailが空では登録できないこと
    it "is invaild without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

# ・passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

# ・passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

# ・nicknameが7文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 7 charactors" do
      user = build(:user, nickname: "0000000")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

# ・nicknameが6文字以下では登録できること
    it "is valid with a nickname that has less than 6 charactors" do
      user = build(:user, nickname: "000000")
      user.valid?
      expect(user).to be_valid
    end

# ・重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email adress" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
# ・passwordが6文字以上であれば登録できること
  it "is valid with a password that has more than 6 chractors" do
    user = build(:user, password: "00000000")
    user.valid?
    expect(user).to be_valid
  end

# ・passwordが5文字以下であれば登録できないこと
  it "is invalid with a password that has less than 5 charactors" do
    user = build(:user, password: "00000")
    user.valid?
    expect(user.errors[:password][0]).to include("is too short")
  end

  end
end
