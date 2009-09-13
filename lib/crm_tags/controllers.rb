class ControllerHooks < FatFreeCRM::Callback::Base

  # :get_accounts and :get_contacts hooks that don't have filters.
  #----------------------------------------------------------------------------
  [ Account, Contact ].each do |klass|
    define_method :"get_#{klass.to_s.tableize}" do |controller, context|
      params, query = controller.params, controller.send(:current_query)

      if query.blank?                                                   # No search query...
        if params[:tag].blank?                                          # No search query, no tags.
          klass.my(context[:records])
        else                                                            # No search query, with tags.
          klass.my(context[:records]).tagged_with(params[:tag], :on => :tags)
        end
      else                                                              # With search query...
        if params[:tag].blank?                                          # With search query, no tags.
          klass.my(context[:records]).search(query)
        else                                                            # With search query, with tags.
          klass.my(context[:records]).search(query).tagged_with(params[:tag], :on => :tags)
        end
      end.paginate(context[:pages])
    end # define_method
  end # each

  # :get_campaigns, :get_leads, and :get_opportunities hooks that have filters.
  #----------------------------------------------------------------------------
  [ Campaign, Lead, Opportunity ].each do |klass|
    define_method :"get_#{klass.to_s.tableize}" do |controller, context|
      session, params, query = controller.session, controller.params, controller.send(:current_query)
      filter = :"filter_by_#{klass.to_s.singularize}_status"

      if session[filter]                                                # With filters...
        filtered = session[filter].split(",")
        if params[:tag].blank?                                          # With filters, no tags...
          if query.blank?                                               # With filters, no tags, no search query.
            klass.my(context[:records]).only(filtered)
          else                                                          # With filters, no tags, with search query.
            klass.my(context[:records]).only(filtered).search(query)
          end
        else                                                            # With filters, with tags...
          if query.blank?                                               # With filters, with tags, no search query.
            klass.my(context[:records]).only(filtered).tagged_with(params[:tag], :on => :tags)
          else                                                          # With filters, with tags, with search query.
            klass.my(context[:records]).only(filtered).search(query).tagged_with(params[:tag], :on => :tags)
          end
        end
      else                                                              # No filters...
        if params[:tag].blank?                                          # No filters, no tags...
          if query.blank?                                               # No filters, no tags, no search query.
            klass.my(context[:records])
          else                                                          # No filters, no tags, with search query.
            klass.my(context[:records]).search(query)
          end
        else                                                            # No filters, with tags...  
          if query.blank?                                               # No filters, with tags, no search query.
            klass.my(context[:records]).tagged_with(params[:tag], :on => :tags)
          else                                                          # No filters, with tags, with search query.
            klass.my(context[:records]).search(query).tagged_with(params[:tag], :on => :tags)
          end
        end
      end.paginate(context[:pages])   
    end # define_method
  end # each

end