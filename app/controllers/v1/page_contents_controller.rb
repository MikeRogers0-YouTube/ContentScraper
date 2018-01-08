class V1::PageContentsController < ApplicationController
  def index
    render json: PageContent.all
  end

  def lookup
    @resource = PageContent.find_or_initialize_by(url: url_param)

    # If the resource is saved already, return it's JSON. Otherwise attempt to save
    # it, which will attempt to index the pages content.
    return render json: @resource if @resource.persisted? || @resource.save

    render :not_found
  end

  private
  def url_param
    params.require(:url)
  end
end
