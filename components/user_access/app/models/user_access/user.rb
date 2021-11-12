# frozen_string_literal: true

module UserAccess
  class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :confirmable
  end
end
