class User < ActiveRecord::Base
  include AuthenticationEngine::User
  include AuthenticationEngine::User::Authorization
  include AuthenticationEngine::User::StateMachine

  # Just keep this in model in case of being called again in customized User model
  # if someone wants to modify configs definded in AuthenticationEngine::User module
  # or add their own configs.
  acts_as_authentic

  # # Authorization plugin
  # acts_as_authorized_user
  # acts_as_authorizable
  # authorization plugin may need this too, which breaks the model
  # attr_accesibles need to merged; this resets it
  # attr_accessible :role_ids
  
  belongs_to :region
  has_many :colaborations
  has_many :areas, :through => :colaborations

  accepts_nested_attributes_for :areas
  
  attr_accessible :region_id, :last_name, :age, :gender, :area_ids
  
  named_scope :with_region, :conditions => :region_id
  
  def self.ranking
    with_region.group_by(&:region).sort_by{|region, users| users.size}.reverse
  end
  
  def has_area?(area)
    areas.include?(area)
  end
  
  def areas_of_colaboration
    areas.map(&:name).join(", ")
  end
 
end
