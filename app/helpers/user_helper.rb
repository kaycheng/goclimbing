module UserHelper
  def avatar(user, size)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize_to_limit: [size, size]), class: "avatar-#{size}" 
    else
      user.username.split(%r{\s*}).first.capitalize
    end
  end
end