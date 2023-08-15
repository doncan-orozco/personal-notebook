# frozen_string_literal: true

class FooterComponent < ApplicationComponent
  def template(&)
    div(class: "flex justify-end bg-gray-50 px-4 py-3 text-right sm:px-6 space-x-4 rounded-md", &)
  end
end
