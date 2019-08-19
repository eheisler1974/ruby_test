require 'httparty'
require 'json'

class WelcomeController < ApplicationController
  

  def index
 
	@lines = []
	@lines = Shingle.grabShingleLines('https://mdms.owenscorning.com/api/v1/product/shingles?zip=43659')
	
	@shingles = []
	@shingles = Shingle.grabShingleData('https://mdms.owenscorning.com/api/v1/product/shingles?zip=43659')
	

  end

end
