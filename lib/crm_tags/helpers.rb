module CrmTags
  module Helpers

    #----------------------------------------------------------------------------
    def tag_links(model)
      model.tag_list.inject([]) do |arr, tag|
        query = controller.send(:current_query) || ""
        hashtag = "##{tag}"
        if query.empty?
          query = hashtag
        elsif !query.include?(hashtag)
          query += " #{hashtag}"
        end
        arr << link_to_function(tag, "crm.search_tagged('#{query}', '#{model.class.to_s.tableize}')", :title => tag)
      end.join(" ")
    end

  end
end

ActionView::Base.send(:include, CrmTags::Helpers)
