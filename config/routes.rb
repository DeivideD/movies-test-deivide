# frozen_string_literal: true

Rails.application.routes.draw do
  mount Movies::API => '/'
  mount Ratings::API => '/'
end
