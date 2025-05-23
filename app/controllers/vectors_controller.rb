# app/controllers/vectors_controller.rb
class VectorsController < ApplicationController
  def calculate
    unless user_signed_in?
      flash.now[:alert] = "Авторизуйтесь для начала работы"
      return render "pages/home"
    end
    service = VectorCalculatorService.new(current_user, params)

    begin
      @result = service.call
    rescue ArgumentError => e
      flash.now[:alert] = e.message
      @result = nil
    end

    render "pages/home"
  end
end
