class PagesController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Displays the homepage for the logged-in user.
  # - Fetches all libraries the current user is associated with.
  # - Loads the most recent notifications for the current user, limited to 10.
  def home
  end
end
