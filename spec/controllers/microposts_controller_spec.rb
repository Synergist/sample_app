require 'spec_helper'

describe MicropostsController do
  render_views
  
  describe "access control" do
    
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :content => "" }
      end
      
      it "should not create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end
      
      it "should rerender the home page" do
        post :create, :micropost => @attr
        response.should render_template('pages/home')
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end
      
      it "should create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost, :count).by(1)
      end
      
      it "should redirect to the home page" do
        post :create, :micropost => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash message" do
        post :create, :micropost => @attr
        flash[:success].should =~ /micropost created/i
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    describe "for an unauthorized user" do
      
      before(:each) do
        @user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user)
        @micropost = FactoryGirl.create(:micropost, :user => @user)
        test_sign_in(wrong_user)
      end
      
      it "should deny access" do
        delete :destroy, :id => @micropost
        response.should redirect_to(root_path)
      end
    end
    
    describe "for an authorized user" do
      
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @micropost = FactoryGirl.create(:micropost, :user => @user)
      end
      
      it "should destory the micropost" do
        lambda do
          delete :destroy, :id => @micropost
          flash[:success].should =~ /deleted/
          response.should redirect_to(root_path)
        end.should change(Micropost, :count).by(-1)
      end
    end
  end
end