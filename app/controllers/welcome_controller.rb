require 'httparty'
require 'json'

class WelcomeController < ApplicationController
  

  def index
 
	#render html: "hello, world!.. its a start" 

	#response = RestClient::Request.new(
        #  :method -> :get,
        #  :url -> 'https://mdms.owenscorning.com/api/v1/product/shingles?zip=43659'
        #).execute
        
	#render html: response.body
	
	#grab the json data and parse it
	response = HTTParty.get('https://mdms.owenscorning.com/api/v1/product/shingles?zip=43659')
	results = JSON.parse(response.body)
	
	@info = []
	@name = []
	@props = Hash[]
	puts results.count
	puts "Shingle Lines"

	#k=0
	#@shingles = [[],[]]
	@lines = []
	@imgs=[]

	#s = Hash[]
	@shingles = []
	props = Hash[]
	
	#@shingles = { 'lines' => [], 'color' => [], 'url' => [] }
	j=0
	results.each do |result|
	
	#loop do
	  i=0
	  
	   @lines << result["name"]
	   #puts result["name"]
	    
	  loop do 
	  	props ={}
	  	props["name"] = result["name"]
			#@shingles['lines'] << result["name"]
			nested_keys = [j, "shingle_colors", i, "name"]
			color = results.dig(*nested_keys)
			props["color"] = color
			#@shingles['color'] << color
		
			nested_keys = [j, "shingle_colors", i, "swatch_160x160_url"]
    	url = results.dig(*nested_keys)
    	props["url"] = url
			#@shingles['url'] << url
		
			
		
		
		
	
			if color == nil
		  	break
			end
			@shingles.push(props)
		#puts p.inspect
		
			#s[result["name"]] =  p
			#s << p
		#puts color
		#puts url
		
			@imgs << url
			i += 1
	  end
	  j += 1
	  if j >= results.count 
	    break
	  end
	#end
	
	end

	puts "here:"
	#puts s.inspect
	#puts s.count
	
	#y = s.map{ |x| x[:name] }.uniq
	#puts y.inspect
	
	@shingles.each do |prop|
		if prop["name"] == "Duration"
			puts prop["name"].to_s  + "-" + prop["color"].to_s
		end
	end
	
	#puts @shingles.inspect
  #for key in s.keys()
  #	puts key
  #	s.each do |sh|
  #		puts sh.inspect
  #		
  #		#puts sh[key].to_s
  #	end
  #end

#s.each do |shin|
#	puts shin.name
#end
=begin	
	results.each do |result|
	  #puts result["name"]
	  @lines << result["name"]
	  @shingles[0] << result["name"]
	puts ""
	puts @shingles[0][k]
	puts ""
	  k += 1
	end
	puts ""
	puts "Shingle - Color"
	j=0
	loop do
	  i=0
	  loop do
	    nested_keys = [j,"shingle_colors", i, "name"]
		color = results.dig(*nested_keys)
	    nested_keys = [j,"shingle_colors", i, "swatch_160x160_url"]
	    swatch_url= results.dig(*nested_keys)
	    if color == nil
	      break
	      
	    end
	    puts @lines[j] + " - " + color
	    @shingles[1] << color
	    puts swatch_url
	    @imgs << swatch_url
  	    i += 1
	    #if i >= 14
	    #  break
	    #end
	  end
	  j += 1
	  if j >= results.count 
	    break
	  end
	end

#results.each do ||
	#  puts shingle_color["shingle_color"][0]["name"]
	#end

	#RestClient.get 'https://mdms.owenscorning.com/api/v1/product/shingles?zip=43659'
        #results = JSON.parse(response.to_str)

	#render html results
=end
  end

end
