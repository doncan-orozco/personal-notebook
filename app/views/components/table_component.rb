# frozen_string_literal: true

class TableComponent < ApplicationComponent
  def initialize(collection:, resource_class:, attributes: [])
    @collection = collection
    @attributes = attributes
    @resource_class = resource_class
  end

  def template
    div(class: "overflow-hidden shadow ring-1 ring-black ring-opacity-5 md:rounded-lg") do
      table(class: "min-w-full divide-y divide-gray-300") do
        thead(class: "bg-gray-50") do
          tr do
            template_header(attributes: @attributes)
          end
        end
        tbody(class: "divide-y divide-gray-200 bg-white") do
          template_body(collection: @collection, attributes: @attributes)
        end
      end
    end
  end

  private

  def attribute_name(attribute)
    @resource_class.human_attribute_name(attribute)
  end

  def template_header(attributes:)
    attributes.each do |attribute|
      th(scope: "col", class: "whitespace-nowrap py-3.5 pl-4 pr-3 text-left text-sm font-semibold") do
        p(class: "inline-flex") { attribute_name(attribute) }
      end
    end

    th(scope: "col", class: "relative py-3.5 pl-3 pr-4 sm:pr-6")
  end

  def template_body(collection:, attributes:)
    collection.each do |record|
      tr(id: dom_id(record)) do
        attributes.each do |attribute|
          td(class: "whitespace-nowrap px-3 py-4 text-sm text-skin-dimmed") do
            plain record.send(attribute)
          end
        end
        td(class: "relative whitespace-nowrap py-4 pl-3 pr-4 text-sm font-medium sm:pr-6") do
          div(class: "flex items-center justify-end space-x-2") do
            a(href: send("#{singular_model_name}_path", record), class: "text-sky-600") { t("helpers.submit.users.show") }
            a(href: send("edit_#{singular_model_name}_path", record)) { t("helpers.submit.users.edit") }
            div do
              button_to t("helpers.submit.users.delete"), send("#{singular_model_name}_path", record),
                method: :delete,
                form: {data: {turbo_confirm: t("confirmations.users.delete")}},
                class: "text-red-600"
            end
          end
        end
      end
    end
    collection_with_empty_row if collection.blank?
  end

  def collection_with_empty_row
    td(class: "text-center whitespace-nowrap px-3 py-4 text-sm", colspan: @attributes.size + 1) { t(:no_records, scope: :generic, model: singular_model_name) }
  end

  def singular_model_name
    @resource_class.model_name.singular
  end

  def plural_model_name
    @resource_class.model_name.plural
  end
end
