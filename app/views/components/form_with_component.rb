# frozen_string_literal: true

class FormWithComponent < ApplicationComponent
  include Phlex::Rails::Helpers::FormWith

  def initialize(model:, scope: nil, url: nil, format: nil, **options)
    @model, @scope, @url, @format, @options = model, scope, url, format, options
  end

  def template(&)
    form_with(model: @model, url: @url, format: @format, **@options) do
      render FormBuilderComponent.new(model: @model, scope: @scope, **@options, &)
    end
  end
end
