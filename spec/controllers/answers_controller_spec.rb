require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)      { User.create!(email: 'test@test.test', password: 'testtest', password_confirmation: 'testtest') }
  let(:user2)     { User.create!(email: 'test2@test.test', password: 'testtest', password_confirmation: 'testtest') }
  let(:question)  { Question.create!(body: 'body', user: user, title: 'title') }
  let(:answer)    { Answer.create!(body: 'body', user: user, question: question) }

  context 'with logged user' do
    describe 'GET new' do
      before do
        sign_in
        get :new, params: { question_id: question.id }
      end

      it { is_expected.to respond_with :ok }
    end

    describe 'GET edit' do
      before do
        sign_in user
        get :edit, params: { question_id: question.id, id: answer.id }
      end

      it { is_expected.to respond_with :ok }
    end

    describe 'POST create' do
      before do
        sign_in user
        post :create, params: {
          question_id: question.id,
          id: answer.id,
          answer: {
            body: 'new_body'
          }
        }
      end

      it { is_expected.to redirect_to question_path(question.id) }
      it 'displays a success flash message'
    end

    describe 'PUT update' do
      before do
        sign_in user
        put :update, params: {
          question_id: question.id,
          id: answer.id,
          answer: {
            body: 'new_body'
          }
        }
      end

      it { is_expected.to redirect_to question_path(question.id) }
      it 'displays a success flash message'
    end

    describe 'DELETE destroy' do
      before do
        sign_in user
        delete :destroy, params: {
          question_id: question.id,
          id: answer.id
        }
      end

      it { is_expected.to redirect_to question_path(question.id) }
      it 'displays a success flash message'
    end
  end

  context 'with logged out user' do
    before do
      sign_in nil
    end

    describe 'GET new' do
      before { get :new, params: { question_id: question.id } }

      it { is_expected.to redirect_to(new_user_session_path) }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'GET edit' do
      before { get :edit, params: { question_id: question.id, id: answer.id } }

      it { is_expected.to redirect_to(new_user_session_path) }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'POST create' do
      before { post :create, params: { question_id: question.id, id: answer.id, answer: { body: 'new_body' } } }

      it { is_expected.to redirect_to(new_user_session_path) }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'PUT update' do
      before { put :update, params: { question_id: question.id, id: answer.id, answer: { body: 'new_body' } } }

      it { is_expected.to redirect_to(new_user_session_path) }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, params: { question_id: question.id, id: answer.id } }

      it { is_expected.to redirect_to(new_user_session_path) }
      it { is_expected.to set_flash[:alert].to match I18n.t('devise.failure.unauthenticated') }
    end
  end
end
