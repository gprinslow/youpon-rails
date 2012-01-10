module ApplicationHelper
  
	#Helper to return the logo
	def logo
		logo = image_tag("logo.png", :alt => "Youpon", :class =>"round")
		if @logo.nil?
			logo
		else
			"Youpon"
		end
	end

  #Return a title for each page
  def title
    base_title = "Youpon"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
