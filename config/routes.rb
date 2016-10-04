# == Route Map
#
#                   Prefix Verb   URI Pattern                                        Controller#Action
#         new_user_session GET    /users/sign_in(.:format)                           devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                           devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                          devise/sessions#destroy
#            user_password POST   /users/password(.:format)                          devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                      devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                     devise/passwords#edit
#                          PATCH  /users/password(.:format)                          devise/passwords#update
#                          PUT    /users/password(.:format)                          devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                            devise/registrations#cancel
#        user_registration POST   /users(.:format)                                   devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                           devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                              devise/registrations#edit
#                          PATCH  /users(.:format)                                   devise/registrations#update
#                          PUT    /users(.:format)                                   devise/registrations#update
#                          DELETE /users(.:format)                                   devise/registrations#destroy
#                     root GET    /                                                  questions#index
#         question_answers POST   /questions/:question_id/answers(.:format)          answers#create
#      new_question_answer GET    /questions/:question_id/answers/new(.:format)      answers#new
#     edit_question_answer GET    /questions/:question_id/answers/:id/edit(.:format) answers#edit
#          question_answer PATCH  /questions/:question_id/answers/:id(.:format)      answers#update
#                          PUT    /questions/:question_id/answers/:id(.:format)      answers#update
#                          DELETE /questions/:question_id/answers/:id(.:format)      answers#destroy
#                questions GET    /questions(.:format)                               questions#index
#                          POST   /questions(.:format)                               questions#create
#             new_question GET    /questions/new(.:format)                           questions#new
#            edit_question GET    /questions/:id/edit(.:format)                      questions#edit
#                 question GET    /questions/:id(.:format)                           questions#show
#                          PATCH  /questions/:id(.:format)                           questions#update
#                          PUT    /questions/:id(.:format)                           questions#update
#                          DELETE /questions/:id(.:format)                           questions#destroy
#

Rails.application.routes.draw do
  devise_for :users

  root to: "questions#index"

  resources :questions do
    resources :answers, except: [:index, :show]
  end
end
