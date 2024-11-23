class NotificationsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Creates a new notification.
  # - Builds a new notification instance using parameters from the form.
  # - Associates the current user with the notification.
  # - Saves the notification and redirects back to the admin dashboard of the associated library with a success message.
  # - If saving fails, redirects back to the previous page with an error message.
  def create
  end

  private

  # Strong parameters to permit only allowed attributes for a notification.
  # - Includes `content` (notification message) and `library_id` (the associated library).
  def notification_params
  end
end
