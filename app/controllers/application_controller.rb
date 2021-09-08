class ApplicationController < ActionController::Base

  protected

  def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :admin
        new_admin_session_path
      else
        new_user_session_path
      end
    end
end
