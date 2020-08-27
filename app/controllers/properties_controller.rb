class PropertiesController < ApplicationController
  def index
    @properties = []
    operation = params[:operation]
    property = params[:property]
    place = params[:place]
        # @properties = Property.where("property_type = 'apartment' AND operation_type = 'rent' AND district LIKE 'L%'")
    if operation or property
      if !operation == "" and !property == ""
        @properties = Property.where(property_type: property , operation_type: operation )
      else
        @properties = Property.where(operation_type: operation) unless operation == ""
        @properties = Property.where(property_type: property) unless property == ""
        @properties = Property.all if operation == "" and property == ""
      end
    else
      @properties = Property.all
    end
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

  def lastest
    @properties = Property.limit(3).order(created_at: :desc)
    render json:@properties
  end
end
