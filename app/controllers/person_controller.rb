class PersonController < ApplicationController
  def index
    @people = Person.all()
  end
end
