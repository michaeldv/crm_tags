require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_sample_tabs, initializer) do
          name "Fat Free CRM Tags"
       authors "Michael Dvorkin, Jose Luis Gordo Romero"
       version "0.2"
   description "Adds tagging support to Fat Free CRM"
  dependencies :"acts-as-taggable-on", :haml, :simple_column_search, :will_paginate
end

require "crm_tags"
