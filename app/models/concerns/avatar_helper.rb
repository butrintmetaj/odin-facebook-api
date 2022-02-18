module AvatarHelper
  extend ActiveSupport::Concern

  class_methods do
    def avatar_url(user)
      user.avatar.url
    end

    def image_url(post)
      post.image.url
    end
  end
end