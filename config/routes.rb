DayCalendar::Application.routes.draw do

  get '/' => 'day#index'
  match '/day/entry' => 'day#new'
  get '/:week' => 'day#index'




end
