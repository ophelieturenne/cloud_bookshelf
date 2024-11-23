class CheckoutsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the checkout specified in the request parameters.
  # Ensures the checkout exists and is accessible to the current user.
  before_action :set_checkout, only: %i[edit update return]

  # Ensures that all actions in this controller call `authorize` for Pundit authorization.
  after_action :verify_authorized

  # Displays a list of checkouts for the current user.
  # - Uses `policy_scope` to enforce authorization and filter accessible checkouts.
  # - Includes associated books and libraries for efficient loading.
  # - Authorizes access to the list of checkouts.
  def index
    authorize @checkout
  end

  # Prepares a new checkout instance for the form.
  # - Authorizes the action to ensure the user can create a new checkout.
  def new
    authorize @checkout
  end

  # Creates a new checkout for the current user.
  # - Builds a checkout instance using strong parameters.
  # - Sets the current user as the checkout owner.
  # - Authorizes the action to ensure the user is allowed to perform it.
  # - Saves the checkout and redirects to the checkouts list with a success message.
  # - If validation fails, renders the form again with error messages.
  def create
    authorize @checkout
  end

  # Marks a book as returned for a specific checkout.
  # - Authorizes the action to ensure the user has permission to return the book.
  # - Updates the checkout status to "returned" and marks the book as available.
  # - Redirects to the checkouts list with a success message.
  def return
    authorize @checkout
  end

  private

  # Fetches the checkout specified in the request parameters.
  # - Ensures the checkout exists and is accessible to the user.
  def set_checkout
  end

  # Strong parameters to permit only allowed attributes for a checkout.
  # - Includes `book_id`, `start_date`, `due_date`, and `status`.
  def checkout_params
  end
end
