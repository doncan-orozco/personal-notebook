# frozen_string_literal: true

class SectionComponent::HeaderComponent < ApplicationComponent
  include Phlex::DeferredRender

  def initialize(title, description)
    @title = title
    @description = description
  end

  def template
    div(class: "sm:flex sm:items-center sm:justify-between") do
      div do
        h3(class: "text-lg font-medium leading-6 text-skin-base") { @title }
        p(class: "mt-1 text-sm text-skin-dimmed") { @description }
      end

      if @action_button
        div(&@action_button)
      end
    end
  end

  def action_button(&block)
    @action_button = block
  end
end
