module HomeHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def url_of_arena(a)
		arena = FutsalPlace.find(a)
		arena_name = (arena.name).gsub(' ', '-').downcase
		showarena_url(a, arena_name)
	end
end
