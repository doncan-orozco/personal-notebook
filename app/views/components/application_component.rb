# frozen_string_literal: true

class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::T
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::DOMID
  include Phlex::Rails::Helpers::ButtonTo
end
