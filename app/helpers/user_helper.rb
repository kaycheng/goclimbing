module UserHelper
  def avatar(user, size)
    image_tag user.avatar.variant(resize_to_limit: [size, size]), class: "avatar-#{size}" if user.avatar.attached?
  end
end