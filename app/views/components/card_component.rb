# frozen_string_literal: true

class CardComponent < ApplicationComponent
  def template(&)
    div(class: "bg-white shadow rounded-md px-4 py-5 sm:p-6 space-y-12", &)
  end

  def section(&)
    render SectionComponent.new(&)
  end

  def footer(&)
    div(class: "bg-gray-50 !-mx-4 !-mb-5 !mt-5 sm:!-mx-6 sm:!-mb-6 sm:!mt-6 rounded-md") do
      render FooterComponent.new(&)
    end
  end
end
