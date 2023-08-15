# frozen_string_literal: true

class SectionComponent < ApplicationComponent
  def template(&)
    div(class: "divide-y space-y-8 divide-gray-200", &)
  end

  def header(title, description, &block)
    render HeaderComponent.new(title, description), &block
  end

  def content(&)
    div(class: "pt-6 space-y-6", &)
  end
end
