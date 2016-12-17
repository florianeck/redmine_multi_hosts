module MultiHostsHelper

  def html_title(*args)
    binding.pry
    app_title = @current_multihost.try(:app_title) || Setting.app_title
    if args.empty?
      title = @html_title || []
      title << @project.name if @project
      title << app_title unless app_title == title.last
      title.reject(&:blank?).join(' - ')
    else
      @html_title ||= []
      @html_title += args
    end
  end

end