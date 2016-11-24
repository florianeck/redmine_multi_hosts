module MultiHosts
  class Hooks < Redmine::Hook::ViewListener

    render_on :view_users_form_preferences, partial: 'users/multi_host_select'
    render_on :view_layouts_base_html_head, partial: 'layouts/multi_host_styles'

  end
end