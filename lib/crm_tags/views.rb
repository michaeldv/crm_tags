class ViewHooks < FatFreeCRM::Callback::Base

  TAGS_FIELD = <<EOS
%tr
  %td{ :valign => :top, :colspan => span }
    .label.req Tags: <small>(comma separated)</small>
    = f.text_field :tag_list, :style => "width:500px"
EOS

  TAG_LINKS = <<EOS
%dt{ :style => (model.is_a?(Contact) ? "padding: 2px 0px 0px 38px" : "") }
  Tags: 
  = tag_links(model)
EOS

  #----------------------------------------------------------------------------
  %w(account campaign contact lead opportunity).each do |model|

    define_method :"#{model}_top_section_bottom" do |view, context|
      Haml::Engine.new(TAGS_FIELD).render(view, :f => context[:f], :span => (model != "campaign" ? 3 : 5))
    end

    define_method :"#{model}_bottom" do |view, context|
      unless context[model.to_sym].tag_list.empty?
        Haml::Engine.new(TAG_LINKS).render(view, :model => context[model.to_sym])
      end
    end

  end
end
