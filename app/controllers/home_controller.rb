require 'open-uri'
require 'JSON'
class HomeController < ApplicationController
	before_action :authenticate_user!
  def index
   

    cnn="http://www.cnn.com"
    huffP = "http://www.huffingtonpost.com"
    nyt = "http://www.nytimes.com"
    wired = "http://www.wired.com"  
    bloomberg = "http://www.bloomberg.com"
    npr = "http://www.npr.org"


     pro = params[:provider]
     if pro == "nyt"
     news_provider = Nokogiri::HTML(open(nyt))
     elsif pro == "wired"
     news_provider = Nokogiri::HTML(open(wired))
     elsif pro == "bloomberg"
      news_provider = Nokogiri::HTML(open(bloomberg))
     elsif pro == "npr"
      news_provider = Nokogiri::HTML(open(npr))
     else
     news_provider = Nokogiri::HTML(open('http://www.huffingtonpost.com'))
     end

     handle = "h4 a"
     if pro == "nyt" || pro ==  "wired"
      handle = "h2 a"
     elsif pro == "bloomberg"
      handle = "a.icon-article-headline"  
     elsif pro == "npr"
      handle = "div.story-text"
     end

     @articles = []
     if pro != "mash" && pro != "npr"
       for a in (0...news_provider.css(handle).length)
        
        @articles << news_provider.css(handle)[a].text
   
       end
   elsif pro == "npr"
    for a in (0...news_provider.css(handle).length)
        
        @articles << news_provider.css(handle)[a].css("h1").text
       end
     else
      mash = open("http://mashable.com/stories.json")
      mmash = JSON.parse(mash.read)
      for a in mmash["new"]
        @articles << a["title"]
      end
      for a in mmash["rising"]
        @articles << a["title"]
      end
      for a in mmash["hot"]
        @articles << a["title"]
      end


   end
 end


  


  def show 
  	nyt = "http://www.nytimes.com"
    wired = "http://www.wired.com"
    bloomberg = "http://www.bloomberg.com"
    npr = "http://www.npr.org"
    pro = params[:prov]
    if pro == "nyt"
     news_provider = Nokogiri::HTML(open(nyt))
     elsif pro == "wired"
     news_provider = Nokogiri::HTML(open(wired))
     elsif pro == "bloomberg"
      news_provider = Nokogiri::HTML(open(bloomberg))
     elsif pro == "npr"
      news_provider = Nokogiri::HTML(open(npr))
     else
     news_provider = Nokogiri::HTML(open('http://www.huffingtonpost.com'))
     end
    selected = params[:article_select].to_i
    handle = "h4 a"
     if pro == "nyt" || pro == "wired"
      handle = "h2 a"
     elsif pro == "bloomberg"
      handle = "a.icon-article-headline"  
     elsif pro == "npr"
      handle = "div.story-text"
     end
    if pro != "bloomberg" && pro != "npr" && pro != "mash"
     url = news_provider.css(handle)[selected][:href]
  elsif pro == "npr"
    url = news_provider.css(handle)[selected].css("a")[1][:href]
  elsif pro == "mash"
    if selected < 10
        mash_selected = selected
        mash_category = "new"
      elsif selected < 20
        mash_selected = selected - 10
        mash_category = "rising"
      else
        mash_selected = selected - 20
        mash_category = "hot"
      end
      mash = open("http://mashable.com/stories.json")
      mmash = JSON.parse(mash.read)
      url = mmash[mash_category][mash_selected]["link"]
  
    else
      url = bloomberg + news_provider.css(handle)[selected][:href]
    end 
    
      body_json = open("http://api.diffbot.com/v3/article?token=8de6c6c3e5fcec13f7b786b833bb35f7&url=#{url}")
      @body = JSON.parse(body_json.read)
      if @body["objects"][0]["html"]
      @text = @body["objects"][0]["html"]
    else
      @text = "Article not available"
    end
    if @body["objects"][0]["title"]
      @title = @body["objects"][0]["title"]
    else
    @title = "Article not available"
    end
    if @body["objects"][0]["images"]
      @image = @body["objects"][0]["images"][0]["url"]
    else
      @image = "http://placekitten.com/g/300/400"
    end
    

    puts "**************#{pro} & #{handle}***********"


end

  def machmail
  	cnn="http://www.cnn.com"
	huffP = "http://www.huffingtonpost.com"
	nyt = "http://www.nytimes.com"
	wired = "http://www.wired.com"	
	bloomberg = "http://www.bloomberg.com"
	npr = "http://www.npr.org"
  	 pro = params[:provider]

  	 if pro == "nyt"
     news_provider = Nokogiri::HTML(open(nyt))
     elsif pro == "wired"
     news_provider = Nokogiri::HTML(open(wired))
     elsif pro == "bloomberg"
     	news_provider = Nokogiri::HTML(open(bloomberg))
     elsif pro == "npr"
     	news_provider = Nokogiri::HTML(open(npr))
  	 else
  	 news_provider = Nokogiri::HTML(open('http://www.huffingtonpost.com'))
     end
     
     handle = "h4 a"
     if pro == "nyt" || pro ==  "wired"
     	handle = "h2 a"
     elsif pro == "bloomberg"
     	handle = "a.icon-article-headline"	
     elsif pro == "npr"
     	handle = "div.story-text"
     end

     @articles = []
     if pro != "mash" && pro != "npr"
	     for a in (0...news_provider.css(handle).length)
	     	
	     	@articles << news_provider.css(handle)[a].text
	 
	     end
	 elsif pro == "npr"
	 	for a in (0...news_provider.css(handle).length)
	     	
	     	@articles << news_provider.css(handle)[a].css("h1").text
	     end
     else
     	mash = open("http://mashable.com/stories.json")
     	mmash = JSON.parse(mash.read)
     	for a in mmash["new"]
     		@articles << a["title"]
     	end
     	for a in mmash["rising"]
     		@articles << a["title"]
     	end
     	for a in mmash["hot"]
     		@articles << a["title"]
     	end
     end

    

  end

  def machshow
  	nyt = "http://www.nytimes.com"
  	wired = "http://www.wired.com"
  	bloomberg = "http://www.bloomberg.com"
  	npr = "http://www.npr.org"
  	pro = params[:prov]
    if pro == "nyt"
     news_provider = Nokogiri::HTML(open(nyt))
     elsif pro == "wired"
     news_provider = Nokogiri::HTML(open(wired))
     elsif pro == "bloomberg"
     	news_provider = Nokogiri::HTML(open(bloomberg))
     elsif pro == "npr"
     	news_provider = Nokogiri::HTML(open(npr))
  	 else
  	 news_provider = Nokogiri::HTML(open('http://www.huffingtonpost.com'))
     end
    selected = params[:article_select].to_i
    handle = "h4 a"
     if pro == "nyt" || pro == "wired"
     	handle = "h2 a"
     elsif pro == "bloomberg"
     	handle = "a.icon-article-headline"	
     elsif pro == "npr"
     	handle = "div.story-text"
     end
    if pro != "bloomberg" && pro != "npr" && pro != "mash"
   	 url = news_provider.css(handle)[selected][:href]
	elsif pro == "npr"
		url = news_provider.css(handle)[selected].css("a")[1][:href]
	elsif pro == "mash"
		if selected < 10
    		mash_selected = selected
    		mash_category = "new"
    	elsif selected < 20
    		mash_selected = selected - 10
    		mash_category = "rising"
    	else
    		mash_selected = selected - 20
    		mash_category = "hot"
    	end
	    mash = open("http://mashable.com/stories.json")
	    mmash = JSON.parse(mash.read)
	    url = mmash[mash_category][mash_selected]["link"]
	
    else
   		url = bloomberg + news_provider.css(handle)[selected][:href]
    end	
    
	    body_json = open("http://api.diffbot.com/v3/article?token=8de6c6c3e5fcec13f7b786b833bb35f7&url=#{url}")
	    @body = JSON.parse(body_json.read)
	    if @body["objects"][0]["html"]
	    @text = @body["objects"][0]["html"]
		else
			@text = "Article not available"
		end
		if @body["objects"][0]["title"]
	    @title = @body["objects"][0]["title"]
		else
		@title = "Article not available"
		end
		if @body["objects"][0]["images"]
	    @image = @body["objects"][0]["images"][0]["url"]
		else
			@image = "http://placekitten.com/g/300/400"
		end
    

    puts "**************#{pro} & #{handle}***********"


  end


end
