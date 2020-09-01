# frozen_string_literal: true

class PropertiesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :valid_landlord?, only: %i[create patch]

  def index
    # Se debe filtrar por el nombre del campo, ej operation_type en lugar de operation (Conversar con Front)
    # Se debe filtrar si es que el Property tiene "is_available" igual a true
    # Se debe incluir los filtros para los demas campos (bedrooms, bathrooms, apartment amenities)
    # Se debe recoger los datos con un property_params. OJO con campos tipo array
    # se debe incluir el local storage para imagenes
    @properties = []
    operation = params[:operation]
    property = params[:property]
    place = params[:place]

    if operation || property
      if (!operation == '') && (!property == '')
        @properties = Property.where(property_type: property, operation_type: operation)
      else
        unless operation == ''
          @properties = Property.where(operation_type: operation)
        end
        unless property == ''
          @properties = Property.where(property_type: property)
        end
        @properties = Property.all if (operation == '') && (property == '')
      end
    else
      @properties = Property.all
    end
    render json: @properties, status: :ok
  end

  def show
    @property = Property.find(params[:id])
    render json: @property, status: :ok if @property
  rescue StandardError => e
    render json: { error: 'property not found' }, status: :not_found
  end

  # TODO: pets_allowed property should be arrive as a boolean because string are transformed
  # to true boolean values except "false" string
  def create
    @property = Property.new(property_params)
    if @property.save
      render json: @property.attributes.merge(images: @property.images.blobs.map { |img| img.filename.to_s })
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def lastest
    @properties = Property.limit(3).order(created_at: :desc)
    render json: @properties, status: :ok
  end

  private

  def property_params
    params.permit(:operation_type, :address, :price, :maintenance, :property_type,
                  :bedrooms, :bathrooms, :area, :pets_allowed, :description,
                  apartment_ameneties: [], building_ameneties: [],
                  close_by: [], images: []).merge({ landlord: current_user })
  end
end
