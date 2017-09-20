module ApplicationHelper
  def gravatar_for(user, option = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email)
    size = option[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  def correct_user(resource)
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
