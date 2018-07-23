require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp@temp.com', phone: '1234567890', password: 'temp', password_confirmation: 'temp')
    expect(user).to be_valid
    expect(User.count).to eq 1
  end

  it "is not valid with unmatching password_confirmation" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp@temp.com', phone: '1234567890', password: 'temp1', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when username not given" do
    user = User.create(name: 'temp', email: 'temp@temp.com', phone: '1234567890', password: 'temp1', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when name not given" do
    user = User.create(username: 'temp', email: 'temp@temp.com', phone: '1234567890', password: 'temp1', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when email not given" do
    user = User.create(username: 'temp', name: 'temp', phone: '1234567890', password: 'temp1', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when phone not given" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp@temp.com', password: 'temp1', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when password not given" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp@temp.com', phone: '1234567890', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when username exists" do
    user1 = User.create(username: 'temp', name: 'temp1', email: 'temp1@temp.com', phone: '1234567891', password: 'temp1', password_confirmation: 'temp1')
    user2 = User.create(username: 'temp', name: 'temp2', email: 'temp2@temp.com', phone: '1234567892', password: 'temp2', password_confirmation: 'temp2')
    expect(user1).to be_valid
    expect(user2).to_not be_valid
    expect(User.count).to eq 1
  end

  it "is not valid when email exists" do
    user1 = User.create(username: 'temp1', name: 'temp1', email: 'temp@temp.com', phone: '1234567891', password: 'temp1', password_confirmation: 'temp1')
    user2 = User.create(username: 'temp2', name: 'temp2', email: 'temp@temp.com', phone: '1234567892', password: 'temp2', password_confirmation: 'temp2')
    expect(user1).to be_valid
    expect(user2).to_not be_valid
    expect(User.count).to eq 1
  end

  it "is not valid when invalid phone is given" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp@temp.com', phone: 'asdfa', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end

  it "is not valid when invalid email is given" do
    user = User.create(username: 'temp', name: 'temp', email: 'temp', phone: 'asdfa', password_confirmation: 'temp2')
    expect(user).to_not be_valid
    expect(User.count).to eq 0
  end
end
