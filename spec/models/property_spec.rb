require 'rails_helper'

RSpec.describe Property, type: :model do
  describe "Properties" do
    it 'should be exists' do
      should validate_presence_of(:address)
      should validate_presence_of(:district)
      should validate_presence_of(:province)
      should validate_presence_of(:property_type)
      should validate_presence_of(:bedrooms)
      should validate_presence_of(:bathrooms)
      should validate_presence_of(:area)
      should validate_presence_of(:description)
      should validate_presence_of(:price)
      should validate_presence_of(:maintenance)
    end
    it "should be a type" do
      should validate_numericality_of(:bedrooms)
      should validate_numericality_of(:bathrooms)
      should validate_numericality_of(:area)
      should validate_numericality_of(:price)
      should validate_numericality_of(:maintenance)
      #should define_enum_for(:property_type)
      #should define_enum_for(:operation_type)
    end
  end
  describe "Relations" do
    it "Properties" do
      should belong_to(:landlord)
      should have_many(:favorites)
      should have_many(:lovers).through(:favorites).source(:user)
      should have_many(:contacts)
      should have_many(:applicants).through(:contacts).source(:user)
      should have_many(:visits)
      should have_many(:visitors).through(:visits).source(:user)
    end
  end
end
