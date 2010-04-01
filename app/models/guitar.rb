class Guitar < ActiveRecord::Base
  include ActivityLogger

  belongs_to :person
  has_many :photos
  has_many :comments, :as => :commentable, :order => :created_at,
                      :dependent => :destroy
  
  validates_presence_of :title
  validates_presence_of :person_id

  before_create :handle_nil_description
  after_create :log_activity

  def self.per_page
    5
  end

  protected
  def handle_nil_description
  end

  def log_activity
    activity = Activity.create! :item => self, :person => person
    add_activities :activity => activity, :person => person
  end

end
