class MainController < ApplicationController
  def index
    @pendings = Source.new_pendings
    @last_corrects = Source.last_correct
  end

  def charte
  end
end
