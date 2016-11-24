module MultiHosts
  class Hooks < Redmine::Hook::ViewListener

    render_on :view_users_form_preferences, partial: 'users/multi_host_select'

  end
end