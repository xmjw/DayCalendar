class DayController < ApplicationController


  def index

  end

  def new

    blob = session[:blobs]

    blob = {:s => params[:s]} unless blob != nil

    puts blob

    session[:blobs] = blob

    respond_to do |format|
      format.js
    end
  end
end
