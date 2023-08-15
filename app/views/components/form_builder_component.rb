# frozen_string_literal: true

class FormBuilderComponent < ApplicationComponent
  include Phlex::Rails::Helpers::Label
  include Phlex::Rails::Helpers::TextField
  include Phlex::Rails::Helpers::TextArea
  include Phlex::Rails::Helpers::Select

  def initialize(model:, scope: nil, **options)
    @model, @scope, @options = model, scope, options
  end

  def template
    yield if block_given?
  end

  def field_with_label(attribute, type: :text_field, **options)
    wrapper_options = options.delete(:wrapper_options) || {}
    wrapper_options[:class] = "space-y-1 #{wrapper_options[:class]}"

    options[:placeholder] = I18n.t("helpers.placeholder.#{@model.model_name.i18n_key}.#{attribute}") if options.dig(:placeholder) == true
    options[:placeholder] = nil if @options.dig(:read_only)
    options[:disabled] ||= @options.dig(:read_only)
    options[:class] = "input w-full #{options[:class]}"
    options[:label_text] ||= t("activerecord.attributes.#{object_name}.#{attribute}")
    options[:value] ||= @model.send(attribute) if @model.respond_to?(attribute)

    maxlength = options.dig(:maxlength)
    maxlength = I18n.t("maxlength.#{@model.model_name.i18n_key}.#{attribute}", default: I18n.t("maxlength.default")) if maxlength.blank? && maxlength != false
    options[:maxlength] = maxlength

    if @model.errors.include?(attribute)
      options[:class] = "#{options[:class]} input-error"
      error_message = @model.errors.messages_for(attribute).first
    end

    div(**wrapper_options) do
      label(@scope || object_name, attribute, options.delete(:label_text), class: "label")
      send(type, @scope || object_name, attribute, **options)
      p(class: "text-sm text-red-600 pt-1") { error_message } if @model.errors.include?(attribute)
    end
  end

  def select_with_label(attribute, choices, options = {}, html_options = {})
    wrapper_options = options.delete(:wrapper_options) || {}
    wrapper_options[:class] = "space-y-1 w-full #{wrapper_options[:class]}"

    html_options[:disabled] ||= @options.dig(:read_only)
    html_options[:class] = "select #{html_options[:class]}"
    options[:label_text] ||= t("activerecord.attributes.#{object_name}.#{attribute}")
    options[:prompt] = I18n.t("helpers.prompt.#{@model.model_name.i18n_key}.#{attribute}") if options.dig(:prompt) == true
    options[:selected] = @model[attribute]

    if @model.errors.include?(attribute)
      html_options[:class] = "#{html_options[:class]} input-error"
      error_message = @model.errors.messages_for(attribute).first
    end

    div(**wrapper_options) do
      label(@scope || object_name, attribute, options.delete(:label_text), class: "label")
      select(@scope || object_name, attribute, choices, options, **html_options)
      p(class: "text-sm text-red-600 pt-1") { error_message } if @model.errors.include?(attribute)
    end
  end

  def fields_for(association, &)
    scope = "#{object_name}[#{association}]"
    render FormBuilderComponent.new(model: @model.send(association), scope: scope, **@options, &)
  end

  def grid(attributes, **options)
    render GridComponent.new(**options) do |grid|
      attributes.each do |attribute, options|
        cell_options = options.delete(:cell_options) || {}
        grid.cell(span: options.delete(:span), position: options.delete(:position), **cell_options) { input_method(attribute, options) }
      end

      yield grid if block_given?
    end
  end

  def cancel(return_path)
    link_to t(:cancel), return_path, class: "button h-10 text-black"
  end

  def submit(value = nil, **options)
    input(type: "submit", name: "commit", value: value, data: {disable_with: value}, class: "button h-10 text-blue-600 border-blue-600 cursor-pointer")
  end

  private

  def object_name
    @object_name ||= @model.model_name.param_key
  end

  def input_method(attribute, options)
    type = options.delete(:type)

    case type
    when :text_field, :text_area
      field_with_label(attribute, type: type, **options)
    when :select
      select_with_label(attribute, options.fetch(:choices, []), options.fetch(:options, {}), options.fetch(:html_options, {}))
    end
  end
end
