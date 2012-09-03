class HighVoltage::PagesController < ApplicationController
  VALID_CHARACTERS = "a-zA-Z0-9~!@$%^&*()#`_+-=<>\"{}|[];',?".freeze

  unloadable
  layout Proc.new { |_| HighVoltage.layout }

  rescue_from ActionView::MissingTemplate do |exception|
    raise ActionController::RoutingError, "No such page: #{params[:id]}"
  end

  def show
    render :template => current_page
  end

  protected

    def current_page
      "#{content_path}#{clean_path}"
    end

    def clean_path
      path = Pathname.new("/#{clean_id}")
      path.cleanpath.to_s[1..-1]
    end

    def content_path
      HighVoltage.content_path
    end

    def clean_id
      params[:id].tr("^#{VALID_CHARACTERS}", '')
    end
end
