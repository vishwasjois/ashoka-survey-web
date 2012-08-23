require 'spec_helper'

describe SessionsController do
  before do 
    @auth = request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:user_owner]
  end

  context "when creating a session" do
    it "assigns the user ID to the session hash" do
      post :create, :provider => 'user_owner'
      response.should redirect_to(root_path)
      session[:user_id].should == @auth['uid']
    end
    
    it "assigns the access token to the session hash" do
      post :create, :provider => 'user_owner'
      response.should redirect_to(root_path)
      session[:access_token].should == @auth['credentials']['token']
    end
  end

  context "when destroying a session" do
    it "assigns the user ID to the session hash" do
      session[:user_id] = "xyz"
      delete :destroy
      response.should redirect_to(root_path)
      session[:user_id].should be_nil
    end
    
    it "assigns the access token to the session hash" do
      session[:access_token] = "1242"
      delete :destroy
      response.should redirect_to(root_path)
      session[:access_token].should be_nil
    end
  end
end
