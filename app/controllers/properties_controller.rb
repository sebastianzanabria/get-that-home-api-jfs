class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    render json:@properties
  end

  def show
    begin
      @property = Property.find(params[:id])
      if @property
        render json:@property
      end
    rescue => exception
      render json: {error: "property not found"}
    end
  end
end
