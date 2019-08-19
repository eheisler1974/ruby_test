require 'httparty'
require 'json'


#TODO Save and retrieve the results of the REST call to a database to prevent multiple round trips to the server during a session

class Shingle < ApplicationRecord

  def self.grabShingleLines(path)
    
    lines = []     #shingle lines
	  
	  response = HTTParty.get(path)
	  results = JSON.parse(response.body)
    
    results.each do |result|
      lines << result["name"]
    end

    return lines	
  end
  
  def self.grabShingleData(path)
    #puts path
    
    shingles = []  #shingle information
	  props = Hash[]  #shingle properties
	
    #grab the json data and parse it
	  response = HTTParty.get(path)
	  results = JSON.parse(response.body)

    j=0
	  results.each do |result|
	
	  i=0
	  
	    
	    loop do 
	  	  props ={}
	  	  props["name"] = result["name"]
			  
			  nested_keys = [j, "shingle_colors", i, "name"]
			  color = results.dig(*nested_keys)
			  props["color"] = color
			
			  nested_keys = [j, "shingle_colors", i, "swatch_160x160_url"]
    	  url = results.dig(*nested_keys)
    	  props["url"] = url
			  
			  if color == nil
		  	  break
			  end
			  
			  shingles.push(props)
		  
			  i += 1
	    end
	    j += 1
	    if j >= results.count 
	      break
	    end
		end
		return shingles
	end
end
