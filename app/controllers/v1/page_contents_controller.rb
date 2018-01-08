class V1::PageContentsController < ApplicationController
  def index
    # Output all the models. `to_json` seemed suitable here. If you wanted to
    # expand further, adding a jBuilder or ActiveModel::Serializer would be better.
    render json: PageContent.all.to_json(only: [:url, :content])
  end

  def lookup
    @resource = PageContent.find_or_initialize_by(url: url_param)

    # If the resource is saved already, return it's JSON. Otherwise attempt to save
    # it, which will attempt to index the pages content.
    return render json: @resource.to_json(only: [:url, :content]) if @resource.persisted? || @resource.save

    head :not_found
  end

  private
  def url_param
    params.require(:url)
  end
end
