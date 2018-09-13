module ActsAsHocAvatarable
  extend ActiveSupport::Concern
  included do
  end

  module ClassMethods
    def acts_as_hoc_avatarable(_options = {})
      require 'digest/md5'
      has_one_attached :avatar
      attr_accessor :avatar_contents
      attr_accessor :avatar_name
      attr_accessor :remove_avatar
      before_save :clear_avatar
      after_save :parse_avatar
    end
  end

  def avatar_url
    unless persisted?
      return nil
    end
    return Rails.application.routes.url_helpers.rails_blob_url(avatar, host: ActsAsHocAvatarable.configuration.default_host) if avatar.attached?
    return "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email ||= '')}" if ActsAsHocAvatarable.configuration.fallback_to_gravatar
    return nil
  end

  def clear_avatar
    if remove_avatar == '1'
      @avatar_contents = nil
      avatar.purge_later
    end
  end

  def parse_avatar
    # If directly uploaded
    unless avatar_contents.nil? || avatar_contents[/(image\/[a-z]{3,4})/] == ''
      content_type = avatar_contents[/(image\/[a-z]{3,4})/]
      content_type = content_type[/\b(?!.*\/).*/]
      contents = avatar_contents.sub /data:((image)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      mini_magick = MiniMagick::Image.read(decoded_data)
      if ActsAsHocAvatarable.configuration.resize_on_create
        mini_magick.resize (ActsAsHocAvatarable.configuration.resize_size)
      end
      decoded_data = mini_magick.to_blob
      filename = avatar_name || "avatar_#{Time.zone.now.to_i}.#{content_type}"
      File.open("#{Rails.root}/tmp/storage/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      avatar.attach(io: File.open("#{Rails.root}/tmp/storage/#{filename}"), filename: filename)
      FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")
    end
  end

end
ActiveRecord::Base.send :include, ActsAsHocAvatarable
