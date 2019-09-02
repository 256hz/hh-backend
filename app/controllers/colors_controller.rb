# Actions for colors
class ColorsController < ApplicationController
  def index
    render json: Color.all
  end

  def generate
    Color.generate(params[:amount].to_i)
    redirect_to '/'
  end
end
