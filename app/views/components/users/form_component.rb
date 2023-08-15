# frozen_string_literal: true

class Users::FormComponent < ApplicationComponent
  def initialize(user:, action:, attributes:, **options)
    @user = user
    @action = action
    @options = options
    @attributes = attributes
  end

  def template
    div(class: "w-9/12 mx-auto") do
      render FormWithComponent.new(model: @user, read_only: @options[:read_only]) do |form|
        render CardComponent.new do |card|
          card.section do |section|
            section.header(t("users.#{@action}.title"), t("users.#{@action}.description"))
            section.content do
              form.grid(@attributes)
            end
          end
          card.footer do |footer|
            form.cancel(users_path)
            form.submit(submit_value) unless @action == :show
          end
        end
      end
    end
  end

  private

  def submit_value
    case @action
    when :new
      t("helpers.submit.user.create")
    when :edit
      t("helpers.submit.user.update")
    end
  end
end
