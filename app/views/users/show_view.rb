# frozen_string_literal: true

class Users::ShowView < ApplicationView
  def initialize(user:)
    @user = user
  end

  def template
    render Users::FormComponent.new(user: @user, action: :show, attributes: user_attributes, read_only: true)
  end

  private

  def user_attributes
    {
      full_name: {span: :full, type: :text_field, placeholder: true},
      email: {span: :half, type: :text_field, placeholder: true},
      username: {span: :half, type: :text_field, placeholder: true},
      bio: {span: :full, type: :text_area, rows: 5, placeholder: true, maxlength: false}
    }
  end
end
