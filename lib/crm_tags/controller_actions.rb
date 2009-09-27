module CrmTags
  module ControllerActions

    # Controller instance method that responds to /controlled/tagged/tag request.
    # It stores given tag as current query and redirect to index to display all
    # records tagged with the tag.
    #----------------------------------------------------------------------------
    def tagged
      self.send(:current_query=, "#" << params[:id]) unless params[:id].blank?
      redirect_to :action => "index"
    end

  end
end

ApplicationController.send(:include, CrmTags::ControllerActions)
