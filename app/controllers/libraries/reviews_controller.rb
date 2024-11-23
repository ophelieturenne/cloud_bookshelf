class Libraries::ReviewsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the library and book specified in the request parameters.
  # Ensures both exist and handles errors if they don't.
  before_action :set_library_and_book

  # Ensures that all actions in this controller call `authorize` for Pundit authorization.
  after_action :verify_authorized

  # Creates a new review for a specific book in the library.
  # - Builds a new review associated with the book and the current user.
  # - Authorizes the action to ensure the user is allowed to add a review.
  # - Saves the review and redirects back to the book's details page with a success message.
  # - If the review fails validation, redirects back with an error message.
  def create
    authorize @review
  end

  # Deletes a review for a specific book in the library.
  # - Finds the review by its ID within the scope of the book.
  # - Authorizes the action to ensure the user is allowed to delete the review.
  # - Deletes the review and redirects back to the book's details page with a success message.
  def destroy
    authorize @review
  end

  private

  # Fetches the library and book specified in the request parameters.
  # - Ensures that both the library and book exist.
  # - Handles cases where they are not found by redirecting to the libraries list with an alert message.
  def set_library_and_book
  end

  # Strong parameters to permit only allowed attributes for a review.
  # - Includes `rating` and `comment` fields.
  def review_params
  end
end
