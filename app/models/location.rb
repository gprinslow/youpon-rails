class Location < ActiveRecord::Base
  belongs_to :merchant
  
  attr_accessible :address1, :address2, :city, :state, :zip
  
  validates :address1,
	  :presence => true,
	  :length => { :within => 1..100 }
	
	validates :address2,
    :length => { :within => 0..100 }
  
  validates :city,
    :presence => true,
    :length => { :within => 1..50 }
  
  state_regex = /\b(?:A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|PA|RI|S[CD]|T[NX]|UT|V[AT]|W[AIVY])\b/
  validates :state,
    :presence => true,
    :format => { :with => state_regex }
  
  zip_regex = /\b[0-9]{5}(?:-[0-9]{4})?\b/
  validates :zip,
    :presence => true,
    :format => { :with => zip_regex }
	
end
