class PersonController < ApplicationController
  def index
    @people = Person.all()
    @games = Game.all().order(created_at: :desc).limit(50)
  end
end
