module UsersHelper
	def gravatar_for(user, size=80)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		# This next line is returned
		if size
			return image_tag(gravatar_url, alt: user.name, class: "gravatar", height: size, width: size)
		end
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
