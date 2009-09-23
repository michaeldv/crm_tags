module CrmTags
  module Helpers

    #----------------------------------------------------------------------------
    def tag_links(model)
      model.tag_list.inject([]) do |arr, tag|
        query = controller.send(:current_query) || ""
        hashtag = "##{tag}"
        query += (query.empty? ? hashtag : " #{hashtag}")
        arr << link_to_function(hashtag, "$('query').value = '#{query}'; crm.search('#{query}', '#{model.class.to_s.tableize}')", :title => tag)
      end.join(", ")
    end

  end
end

ActionView::Base.send(:include, CrmTags::Helpers)
