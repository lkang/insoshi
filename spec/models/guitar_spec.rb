require File.dirname(__FILE__) + '/../spec_helper'

describe Guitar do

  before(:each) do
    @person = people(:quentin)
    @guitar = @person.guitars.build(:title => "Gibson 335",
                                    :specs => "1988 TD",
			            :description => "Larry Carlton")
  end

  it "should be valid" do
    @guitar.should be_valid
  end

  it "should require a title" do
    guitar = Guitar.new
    guitar.should_not be_valid
    guitar.errors.on(:title).should_not be_empty
  end

  it "should require a person_ide" do
    guitar = Guitar.new
    guitar.should_not be_valid
    guitar.errors.on(:person_id).should_not be_empty
  end
  
  it "should have an associated person" do
    @guitar.person.should == @person
  end
  

  describe "guitar activity associations" do
    
    before(:each) do
      @guitar.save!
      @activity = Activity.find_by_item_id(@guitar)
    end
    
    it "should have an activity" do
      @activity.should_not be_nil
    end
    
    it "should add an activity to the poster" do
      @guitar.person.recent_activity.should contain(@activity)
    end

    it "should destroy the activity if the guitar is destroyed" do
      guitar = @guitar
      @guitar.destroy
      Activity.find_by_item_id(guitar).should be_nil
    end

  end
  
  describe "comment associations" do
    
    before(:each) do
      @guitar.save
      @comment = @guitar.comments.unsafe_create(:body => "The body",
                                              :commenter => people(:aaron))
    end
    
    it "should have associated comments" do
      @guitar.comments.should_not be_empty
    end
    
    it "should add activities to the poster" do
      @guitar.comments.each do |comment|
        activity = Activity.find_by_item_id(comment)
        @guitar.person.activities.should contain(activity)
      end
    end
    
    it "should destroy the comments if the guitar is destroyed" do
      comments = @guitar.comments
      @guitar.destroy
      comments.each do |comment|
        comment.should_not exist_in_database
      end
    end
    
    it "should destroy the comments activity if the guitar is destroyed" do
      comments = @guitar.comments
      @guitar.destroy
      comments.each do |comment|
        Activity.find_by_item_id(comment).should be_nil
      end
    end
  end
end
