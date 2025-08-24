class AuthorizationController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_master_access, only: [ :index, :update_user_role ]

  def index
    @user_role = current_user.role
    @permissions = get_user_permissions
    @all_users = User.all.order(:email) if current_user.can_manage_users?
  end

  def update_user_role
    @user = User.find(params[:user_id])

    if @user.update(role: params[:role])
      redirect_to authorization_path, notice: "User role updated successfully."
    else
      redirect_to authorization_path, alert: "Failed to update user role."
    end
  end

  private

  def ensure_master_access
    unless current_user.can_access_authorization?
      redirect_to root_path, alert: "You do not have permission to access permission page"
    end
  end

  def get_user_permissions
    permissions = []

    case current_user.role
    when "master"
      permissions = [
        "Full system access",
        "Manage all users and their roles",
        "Delete users",
        "Manage publishers",
        "Create and manage posts",
        "Access admin panel",
        "View all content"
      ]
    when "admin"
      permissions = [
        "Access admin panel",
        "View all users (read-only)",
        "Manage publishers",
        "View all posts",
        "Limited administrative access"
      ]
    when "user"
      permissions = [
        "Create and manage own posts",
        "View published content",
        "Edit own profile",
        "Basic user access"
      ]
    end

    permissions
  end
end
