require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PostsController do

  it 'should not be accessible if not logged in' do
    get :index
    response.should redirect_to(new_user_session_path)
    get :new
    response.should redirect_to(new_user_session_path)
    post :create
    response.should redirect_to(new_user_session_path)
    delete :destroy, { id: 1 }
    response.should redirect_to(new_user_session_path)
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Post authored by current user' do
        user = create :user
        sign_in user
        expect {
          post :create, {:post => { text: 'foo' }}
        }.to change(Post, :count).by(1)
        Post.first.user.should == user
      end
    end
  end

  describe 'GET index' do
    it 'should filter by tag param' do
      p1 = create :post
      p1.tags << Tag.create!(name: 'foobar')
      p1.save
      create :post
      sign_in User.first
      get :index, tag: p1.tags[0].id
      assigns(:posts).should == [p1]
    end
  end
end
