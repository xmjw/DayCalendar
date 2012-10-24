DayCalendar::Application.routes.draw do

  get '/' => 'day#index'

  match '/day/entry' => 'day#new'
end
