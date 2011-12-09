module UsersHelper
	def gravatar_for(user, options = { :size => 50})
		gravatar_image_tag(user.email.downcase, 
			:alt => h(user.email), 
			:class => 'gravatar',
			:gravatar => options)
	end
end
