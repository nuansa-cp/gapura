class EventsController < ApplicationController
  include EventsHelper

  def index
    get_all_event
  end

  def show
    set_event
    not_found if !performed? && (@event.year >= 2019)
  end
end
