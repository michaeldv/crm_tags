class ControllerHooks < FatFreeCRM::Callback::Base

  # :get_accounts and :get_contacts hooks that don't have filters.
  #----------------------------------------------------------------------------
  [ Account, Contact ].each do |klass|
    define_method :"get_#{klass.to_s.tableize}" do |controller, context|
      params, search_string = controller.params, controller.send(:current_query)
      query, tags = parse_query_and_tags(search_string)

      if query.blank?                                                   # No search query...
        if tags.blank?                                                  # No search query, no tags.
          klass.my(context[:records])
        else                                                            # No search query, with tags.
          klass.my(context[:records]).tagged_with(tags, :on => :tags)
        end
      else                                                              # With search query...
        if tags.blank?                                                  # With search query, no tags.
          klass.my(context[:records]).search(query)
        else                                                            # With search query, with tags.
          klass.my(context[:records]).search(query).tagged_with(tags, :on => :tags)
        end
      end.paginate(context[:pages])
    end # define_method
  end # each

  # :get_campaigns, :get_leads, and :get_opportunities hooks that have filters.
  #----------------------------------------------------------------------------
  [ Campaign, Lead, Opportunity ].each do |klass|
    define_method :"get_#{klass.to_s.tableize}" do |controller, context|
      session, params, search_string = controller.session, controller.params, controller.send(:current_query)
      query, tags = parse_query_and_tags(search_string)
      filter = :"filter_by_#{klass.to_s.downcase.singularize}_status"

      if session[filter]                                                # With filters...
        filtered = session[filter].split(",")
        if tags.blank?                                                  # With filters, no tags...
          if query.blank?                                               # With filters, no tags, no search query.
            klass.my(context[:records]).only(filtered)
          else                                                          # With filters, no tags, with search query.
            klass.my(context[:records]).only(filtered).search(query)
          end
        else                                                            # With filters, with tags...
          if query.blank?                                               # With filters, with tags, no search query.
            klass.my(context[:records]).only(filtered).tagged_with(tags, :on => :tags)
          else                                                          # With filters, with tags, with search query.
            klass.my(context[:records]).only(filtered).search(query).tagged_with(tags, :on => :tags)
          end
        end
      else                                                              # No filters...
        if tags.blank?                                                  # No filters, no tags...
          if query.blank?                                               # No filters, no tags, no search query.
            klass.my(context[:records])
          else                                                          # No filters, no tags, with search query.
            klass.my(context[:records]).search(query)
          end
        else                                                            # No filters, with tags...  
          if query.blank?                                               # No filters, with tags, no search query.
            klass.my(context[:records]).tagged_with(tags, :on => :tags)
          else                                                          # No filters, with tags, with search query.
            klass.my(context[:records]).search(query).tagged_with(tags, :on => :tags)
          end
        end
      end.paginate(context[:pages])   
    end # define_method
  end # each

  # Auto complete hook that gets called from application_controller.rb.
  #----------------------------------------------------------------------------
  def auto_complete(controller, context = {})
    query, tags = parse_query_and_tags(context[:query])
    klass = controller.controller_name.classify.constantize
    if tags.empty?
      klass.my(:user => context[:user], :limit => 10).search(query)
    else
      klass.my(:user => context[:user], :limit => 10).search(query).tagged_with(tags, :on => :tags)
    end
  end

  private
  # Somewhat simplistic parser that extracts query and hash-prefixed tags from
  # the search string and returns them as two element array, for example:
  #
  # "#real Billy Bones #pirate" => [ "Billy Bones", "real, pirate" ]
  #----------------------------------------------------------------------------
  def parse_query_and_tags(search_string)
    query, tags = [], []
    search_string.scan(/[\w#]+/).each do |token|
      if token.starts_with?("#")
        tags << token[1 .. -1]
      else
        query << token
      end
    end
    [ query.join(" "), tags.join(", ") ]
  end

end
