class PagesController < ApplicationController

  def home

  end

  def about
	@title = "About"
  end

  def help
	@title = "Help"
  end

  def contact
	@title = "Contact Us"
  end

end
