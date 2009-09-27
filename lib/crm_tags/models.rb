# Make all core models act as taggable.
#----------------------------------------------------------------------------
[ Account, Campaign, Contact, Lead, Opportunity ].each do |klass|
  klass.class_eval { acts_as_taggable_on :tags }
end
