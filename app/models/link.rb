class Link
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :url, type: String

  validates_presence_of :title
  validates_presence_of :url
end
