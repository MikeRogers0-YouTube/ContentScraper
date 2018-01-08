class V1::PageContentsController < ApplicationController
  def index
    render json: PageContent.all
  end

  def lookup
    @resource = PageContent.find_or_initialize_by(url: url_param)

    if @resource.valid?
      render json: @resource
    else
      render :not_found
    end
  end

  private
  def url_param
    params.require(:url)
  end
end
