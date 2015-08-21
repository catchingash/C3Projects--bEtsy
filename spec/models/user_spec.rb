require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model validation" do
    it "requires a name, email and password with matching confirmation to be valid" do
      user = build :user
      expect(user).to be_valid
    end

    it "requires the name to be unique" do
      user1 = create :user, name: "frank"
      user2 = build :user, name: "frank"

      expect(user2).to_not be_valid
      expect(user2.errors.keys).to include(:name)
    end

    it "requires the name to be unique, not case-sensitive, FRANK is the same as frank" do
      user1 = create :user, name: "FRANK"
      user2 = build :user, name: "frank"

      expect(user2).to_not be_valid
      expect(user2.errors.keys).to include(:name)
    end

    it "requires the email to be unique" do
      user1 = create :user, email: "email@example.com"
      user2 = build :user, email: "email@example.com"

      expect(user2).to_not be_valid
      expect(user2.errors.keys).to include(:email)
    end

    it "email needs an @ sign, all the time" do
      user = build :user, email: "frankmail"

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:email) #testing that it's failing b/c title is required
    end

    it "requires the password confirmation to match" do
      user = build :user, password_confirmation: "franklin"

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:password_confirmation)
    end
  end
end
