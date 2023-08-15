# frozen_string_literal: true

class Users::NewView < ApplicationView
  def initialize(user: User.new)
    @user = user
  end

  def template
    render Users::FormComponent.new(user: @user, action: :new, attributes: user_attributes)
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
