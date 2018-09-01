class Event < ActiveRecord::Base
    has_attached_file   :photo,
                        :url  => "/assets/events/:id/:style/:basename.:extension",
                        :path => ":rails_root/public/assets/events/:id/:style/:basename.:extension"

    validates_attachment_presence :photo
    validates_attachment_size :photo, :less_than => 5.megabytes
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

    def as_json(options={})
		super(
            except: [:photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :created_at, :updated_at],
			methods: [:photo_url]
		)
    end
    
    def photo_url
        self.photo.url
    end
end