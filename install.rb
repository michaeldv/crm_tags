# Install hook code here
puts <<-EOS
The Tags adds tagging support to all major Fat Free CRM models. To search by tag enter its
name prefixed by # character. For example:

  Search: hello #world

In this example "hello" is regular search string, and "world" is a tag.

The Tags plugin depends on [acts-as-taggable-on] plugin which must be installed as follows:

  $ ./script/plugin install git://github.com/mbleigh/acts-as-taggable-on.git
  $ ./script/generate acts_as_taggable_on_migration
  $ rake db:migrate

EOS