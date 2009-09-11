class AccountHook < FatFreeCRM::Callback::Base

  HAML = <<EOS
%tr
  %td(valign="top" colspan="3")
    .label.req Tags:
    = f.text_field :tag_list, :style => "width:500px"
EOS

  def account_top_section_bottom(view, context = {})
    Haml::Engine.new(HAML).render(view, :f => context[:f])
  end 

end
