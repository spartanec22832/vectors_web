class VectorsController < ApplicationController
  def calculate
    begin
      @result = VectorCalculatorService.new(params).call
    rescue ArgumentError => e
      flash.now[:alert] = e.message
      @result = nil
    end

    render "pages/home"
  end
end
