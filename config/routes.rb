# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api/v1/doc'
  mount Rswag::Api::Engine => '/api/v1/doc'
  mount Movies::API => '/'
  mount Ratings::API => '/'
end
