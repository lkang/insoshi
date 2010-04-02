require File.dirname(__FILE__) + '/../spec_helper'

describe Photo do
  
  before(:each) do
    @filename = "rails.png"
    @person = people(:quentin)
    @gallery = galleries(:valid_gallery)
    @image = uploaded_file(@filename, "image/png")
  end
  
  it "should upload successfully" do
    new_photo.should be_valid
  end
  
  it "should be invalid without person_id" do
    @person = nil
    new_photo.should_not be_valid
  end
  
  it "should be invalid without gallery_id" do
    @gallery = nil
    new_photo.should_not be_valid
  end
  
  
  it "should have an associated person" do
    new_photo.person.should == @person
  end
  
  it "should not have default AttachmentFu errors for an empty image" do
    photo = new_photo(:uploaded_data => nil)
    photo.should_not be_valid
    photo.errors.on(:size).should be_nil
    photo.errors.on(:base).should_not be_nil
  end
  
  describe "photo activity associations" do
    
    before(:each) do
      @photo = new_photo
      @photo.save!
      @activity = Activity.find_by_item_id(@photo)
    end
    
    it "should have an activity" do
      @activity.should_not be_nil
    end
    
    it "should add an activity to the poster" do
      @photo.person.recent_activity.should contain(@activity)
    end
  end
  
  describe "comment associations" do
    
    before(:each) do
      @photo = new_photo
      @photo.save
      @comment = @photo.comments.unsafe_create(:body => "The body",
                                              :commenter => people(:aaron))
    end
    
    it "should have associated comments" do
      @photo.comments.should_not be_empty
    end
    
    it "should add activities to the poster" do
      @photo.comments.each do |comment|
        activity = Activity.find_by_item_id(comment)
        @photo.person.activities.should contain(activity)
      end
    end
    
    it "should destroy the comments if the photo is destroyed" do
      comments = @photo.comments
      @photo.destroy
      comments.each do |comment|
        comment.should_not exist_in_database
      end
    end
    
    it "should destroy the comments activity if the photo is destroyed" do
      comments = @photo.comments
      @photo.destroy
      comments.each do |comment|
        Activity.find_by_item_id(comment).should be_nil
      end
    end
  end

  private
  
    def new_photo(options = {})
      Photo.new({ :uploaded_data => @image,
                  :person        => @person,
                  :gallery       => @gallery }.merge(options))
    end


end
