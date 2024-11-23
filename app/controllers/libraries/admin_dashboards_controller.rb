class Libraries::AdminDashboardsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the library specified in the request parameters and authorizes it.
  # Ensures that the current user has admin-level access to the library.
  before_action :set_library

  # Ensures that all actions in this controller call `authorize` for Pundit authorization.
  after_action :verify_authorized

  # Displays the admin dashboard for a specific library.
  # - Authorizes the `admin_dashboard?` policy to ensure the user is an admin of the library.
  # - Loads all books associated with the library.
  # - Loads all users who are members of the library.
  # - Loads all notifications for the library, ordered by the most recent first.
  # - Loads all pending reservations (checkouts) for the library, including associated books and users.
  def show
    authorize @library, :admin_dashboard?
  end

  # Approves a pending book reservation.
  # - Finds the pending reservation (checkout) by its ID from the request parameters.
  # - Authorizes the action on the associated book to ensure the user has admin access to approve it.
  # - Updates the status of the reservation to "approved" and sets the approval timestamp.
  # - Reduces the quantity of available copies for the reserved book by 1.
  # - If no copies of the book are left, updates the book's status to "not_available."
  # - Sets a flash message to notify the admin of the successful approval.
  # - Redirects back to the admin dashboard for the library.
  def approve_reservation
    authorize @checkout.book

  end

  # Denies a pending book reservation.
  # - Authorizes the action using the `admin_dashboard?` policy to ensure the user has admin access.
  # - Finds the pending reservation (checkout) by its ID from the request parameters.
  # - Updates the status of the reservation to "denied."
  # - If there are no more pending reservations for the book, updates the book's status to "available."
  # - Sets a flash message to notify the admin of the successful denial or an error message if the reservation was not found.
  # - Redirects back to the admin dashboard for the library.
  def deny_reservation
    authorize @library, :admin_dashboard?
  end

  private

  # Fetches the library and checks admin-level authorization.
  # - Finds the library by its ID from the request parameters.
  # - Authorizes the library using the `admin_dashboard?` policy to ensure the user is an admin.
  # - Handles the case where the library is not found by redirecting the user with an alert message.
  def set_library
    authorize @library, :admin_dashboard?
  end
end
