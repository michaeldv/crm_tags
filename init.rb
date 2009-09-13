require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_sample_tabs, initializer) do
          name "Fat Free CRM Tags"
       authors "Michael Dvorkin, Jose Luis Gordo Romero"
       version "0.1"
   description "Adds tagging support to Fat Free CRM"
  dependencies :"acts-as-taggable-on", :haml, :simple_column_search, :uses_mysql_uuid, :uses_user_permissions, :will_paginate
end

require "crm_tags"
