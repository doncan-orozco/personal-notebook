# frozen_string_literal: true

class CellComponent < ApplicationComponent
  def initialize(span: :single, position: nil, **options)
    @span = span
    @position = position
    @options = options
  end

  def template(&)
    @options[:class] = "#{start} #{span_size} #{@options[:class]}"
    div(**@options, &)
  end

  def grid(&)
    render GridComponent.new(&)
  end

  private

  def span_size
    case @span
    when :single
      "sm:col-span-2"
    when :double
      "sm:col-span-4"
    when :half
      "sm:col-span-3"
    when :full
      "sm:col-span-6"
    when nil
      "sm:col-span-2"
    else
      @span
    end
  end

  def start
    case @position
    when :start
      "sm:col-start-1"
    when :middle
      "sm:col-start-3"
    when :end
      "sm:col-start-5"
    else
      "sm:col-start-auto"
    end
  end
end
