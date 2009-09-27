require "crm_tags/models"               # Inject "acts_as_taggable" to core models.
require "crm_tags/controller_actions"   # Inject :tagged controller instance method.
require "crm_tags/view_helpers"         # Inject tag formatting helpers.
require "crm_tags/controller_hooks"     # Define controller hooks to be able to search assets by tag.
require "crm_tags/view_hooks"           # Define view hooks that provide tag support in views.
