require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET users" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST users" do
    it "creates new user and redirects to root" do
      get :new
    end
  end
end
