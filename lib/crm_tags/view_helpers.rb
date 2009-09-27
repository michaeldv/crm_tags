module CrmTags
  module ViewHelpers

    # Generate tag links for use on asset index pages.
    #----------------------------------------------------------------------------
    def tags_for_index(model)
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

    # Generate tag links for the asset landing page (shown on a sidebar).
    #----------------------------------------------------------------------------
    def tags_for_show(model)
      model.tag_list.inject([]) do |arr, tag|
        arr << link_to(tag, url_for(:action => "tagged", :id => tag), :title => tag)
      end.join(" ")
    end

  end
end

ActionView::Base.send(:include, CrmTags::ViewHelpers)
