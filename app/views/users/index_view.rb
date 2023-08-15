# frozen_string_literal: true

class Users::IndexView < ApplicationView
  def initialize(users: User.none)
    @users = users
  end

  def template
    div(class: "w-9/12 mx-auto") do
      div(class: "flex justify-between items-center") do
        h1(class: "font-bold text-4xl") { t("users.index.title") }
        link_to t("helpers.submit.user.new"), new_user_path, class: "rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
      end

      div(id: "users", class: "min-w-full pt-4") do
        render TableComponent.new(collection: @users, resource_class: User, attributes: [:email, :username, :full_name])
      end
    end
  end
end
