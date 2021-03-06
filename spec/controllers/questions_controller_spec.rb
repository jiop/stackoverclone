require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { User.new(email: 'test@test.test', password: 'testtest', password_confirmation: 'testtest') }
  let(:user2) { User.create!(email: 'test2@test.test', password: 'testtest', password_confirmation: 'testtest') }
  let(:question) { Question.create!(body: 'body', user: user, title: 'title') }

  let(:valid_question_attributes) { { user: user, body: 'text', title: 'title' } }
  let(:invalid_question_attributes) { Hash.new }

  context 'with logged user' do
    before do
      sign_in user2
    end

    describe 'GET #index' do
      before { get :index }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }

      it 'assigns all questions as @questions' do
        sign_in user
        get :index, params: {}
        expect(assigns(:questions)).to eq([question])
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: question.id } }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }

      it 'assigns the requested question as @question' do
        sign_in user
        get :show, params: { id: question.to_param }
        expect(assigns(:question)).to eq(question)
      end
    end

    describe 'GET #new' do
      before { get :new }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }

      it 'assigns a new question as @question' do
        sign_in user
        get :new, params: {}
        expect(assigns(:question)).to be_a_new(Question)
      end
    end

    describe 'GET #edit' do
      before do
        sign_in user
        get :edit, params: { id: question.id }
      end

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }

      it 'assigns the requested question as @question' do
        sign_in user
        get :edit, params: { id: question.to_param }
        expect(assigns(:question)).to eq(question)
      end
    end

    describe 'POST #create' do
      before { post :create, params: { question: { body: 'body2', title: 'title2' } } }

      it { is_expected.to redirect_to question_path(Question.last.id) }

      context 'with valid params' do
        it 'creates a new Question' do
          sign_in user
          expect { post :create, params: { question: valid_question_attributes } }.to change(Question, :count).by(1)
        end

        it 'assigns a newly created question as @question' do
          sign_in user
          post :create, params: { question: valid_question_attributes }
          expect(assigns(:question)).to be_a(Question)
          expect(assigns(:question)).to be_persisted
        end

        it 'redirects to the created question' do
          sign_in user
          post :create, params: { question: valid_question_attributes }
          expect(response).to redirect_to(Question.last)
        end
      end
    end

    describe 'PUT #update' do
      before do
        put :update, params: { id: question.id, question: { body: 'new_body' } }
      end

      it { is_expected.to redirect_to(question_path(question.id)) }
      it 'displays a success flash message'

      context 'with valid params' do
        let(:new_attributes) do
          skip('Add a hash of attributes valid for your model')
        end

        it 'updates the requested question' do
          sign_in user
          put :update, params: { id: question.to_param, question: new_attributes }
          question.reload
          skip('Add assertions for updated state')
        end

        it 'assigns the requested question as @question' do
          sign_in user
          put :update, params: { id: question.to_param, question: valid_question_attributes }
          expect(assigns(:question)).to eq(question)
        end

        it 'redirects to the question' do
          sign_in user
          put :update, params: { id: question.to_param, question: valid_question_attributes }
          expect(response).to redirect_to(question)
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        delete :destroy, params: { id: question.id }
      end

      it { is_expected.to redirect_to questions_path }
      it 'displays a success flash message'

      it 'destroys the requested question' do
        question1 = Question.create!(valid_question_attributes)
        sign_in user
        expect do
          delete :destroy, params: { id: question1.id }
        end.to change(Question, :count).by(-1)
      end

      it 'redirects to the questions list' do
        question2 = Question.create!(valid_question_attributes)
        sign_in user
        delete :destroy, params: { id: question2.id }
        expect(response).to redirect_to(questions_url)
      end
    end
  end

  context 'with user is logged out' do
    before do
      sign_in nil
    end

    describe 'GET index' do
      before { get :index }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'GET show' do
      before { get :show, params: { id: question.id } }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'GET edit' do
      before { get :edit, params: { id: question.id } }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'POST create' do
      before { post :create, params: { question: { body: 'body', title: 'title' } } }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'PUT update' do
      before { put :update, params: { id: question.id, question: { body: 'body', title: 'title' } } }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, params: { id: question.id } }

      it { is_expected.to redirect_to new_user_session_path }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end
  end
end
