class ViewHooks < FatFreeCRM::Callback::Base

  HAML = <<EOS
%tr
  %td{ :valign => :top, :colspan => span }
    .label.req Tags:
    = f.text_field :tag_list, :style => "width:500px"
EOS

  %w(account campaign contact lead opportunity).each do |model|
    define_method :"#{model}_top_section_bottom" do |view, context|
      Haml::Engine.new(HAML).render(view, :f => context[:f], :span => (model != "campaign" ? 3 : 5))
    end
  end

end
