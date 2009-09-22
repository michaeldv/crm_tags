module CrmTags
  module Helper

    def tag_links(model)
      model.tag_list.inject([]) do |arr, tag|
        # arr << link_to(tag, url_for(:action => "index", :tag => tag), :title => tag)
        arr << link_to_function(tag, "$('query').value += ($('query').value.length > 0 ? ' ##{tag}' : '##{tag}'); crm.search('##{tag}', '#{model.class.to_s.tableize}')", :title => tag)
      end.join(", ")
    end

  end
end

ActionView::Base.send(:include, CrmTags::Helper)
