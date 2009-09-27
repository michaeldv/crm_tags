class ViewHooks < FatFreeCRM::Callback::Base

  TAGS_FIELD = <<EOS
%tr
  %td{ :valign => :top, :colspan => span }
    .label.req Tags: <small>(comma separated)</small>
    = f.text_field :tag_list, :style => "width:500px"
EOS

  TAGS_LINKS = <<EOS
%dt{ :style => (model.is_a?(Contact) ? "padding: 2px 0px 0px 38px" : "") }
  .tags= tag_links(model)
EOS

  TAGS_STYLES = <<EOS
.tags, .list li dt .tags
  a:link, a:visited
    :background lightsteelblue
    :color white
    :font-weight normal
    :padding 0px 6px 1px 6px
    :-moz-border-radius 8px
    :-webkit-border-radius 8px
  a:hover
    :background steelblue
    :color yellow
EOS

  TAGS_JAVASCRIPT = <<EOS
crm.search_tagged = function(query, controller) {
  if ($('query')) {
    $('query').value = query;
  }
  crm.search(query, controller);
}
EOS

  #----------------------------------------------------------------------------
  def inline_styles(view, context = {})
    Sass::Engine.new(TAGS_STYLES).render
  end

  #----------------------------------------------------------------------------
  def javascript_epilogue(view, context = {})
    TAGS_JAVASCRIPT
  end

  #----------------------------------------------------------------------------
  %w(account campaign contact lead opportunity).each do |model|

    define_method :"#{model}_top_section_bottom" do |view, context|
      Haml::Engine.new(TAGS_FIELD).render(view, :f => context[:f], :span => (model != "campaign" ? 3 : 5))
    end

    define_method :"#{model}_bottom" do |view, context|
      unless context[model.to_sym].tag_list.empty?
        Haml::Engine.new(TAGS_LINKS).render(view, :model => context[model.to_sym])
      end
    end

  end
end
