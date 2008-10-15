class MigratePhotoData < ActiveRecord::Migration
  
  def self.up
    # For each person, create a gallery and put all their photos there.
    Person.find(:all).each do |person|
      gallery = person.galleries.new
      gallery.title = "Primary gallery"
      gallery.primary_photo_id = person.photo.id unless person.photo.nil?
      Gallery.skip_callback(:log_activity) do
        gallery.save!
      end
      person.photos.each do |photo|
        photo.gallery_id = gallery.reload.id
        photo.avatar = photo.primary
        Photo.skip_callback(:log_activity) do
          photo.save!
        end
      end
    end
  end

  def self.down
    Gallery.find(:all).each do |gallery|
      gallery.destroy
    end
    Photo.find(:all).each do |photo|
      Photo.skip_callback(:log_activity) do
        photo.gallery_id = nil
        photo.primary = photo.avatar
        photo.save(false)
      end
    end
  end
end