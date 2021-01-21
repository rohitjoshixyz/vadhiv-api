class LinksController < ApplicationController
  before_action :set_link, only: [:show, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
    json_response(@links)
  end

  # POST /links
  def create
    @link = Link.create(link_params)
    if @link.persisted?
      json_response(@link, :created)
    else
      json_response(@link.errors, :unprocessable_entity)
    end
  end

  # GET /links/:id
  def show
    json_response(@link)
  end

  # PUT /links/:id
  def update
    @link.update(link_params)
    head :no_content
  end

  # DELETE /links/:id
  def destroy
    @link.destroy
    head :no_content
  end

  private

  def link_params
    # whitelist params
    params.permit(:title, :url)
  end

  def set_link
    @link = Link.find(params[:id])
  end  
end
