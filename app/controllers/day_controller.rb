class DayController < ApplicationController


  def index

  end

  def new

    @entry = "some crap"


    respond_to do |format|
      format.js
    end
  end
end
