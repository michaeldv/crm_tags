module Ext
  def self.included(base)
    base.instance_eval do
      acts_as_taggable_on :tags 
    end
  end
end