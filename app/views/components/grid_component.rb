# frozen_string_literal: true

class GridComponent < ApplicationComponent
  def initialize(**options)
    @options = options
  end

  def template(&)
    @options[:class] = "grid grid-cols-1 sm:grid-cols-6 gap-y-6 gap-x-4 #{@options[:class]}"
    div(**@options, &)
  end

  def cell(span: :single, position: nil, **options, &)
    render CellComponent.new(span: span, position: position, **options, &)
  end
end
