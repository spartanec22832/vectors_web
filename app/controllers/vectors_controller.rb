class VectorsController < ApplicationController
  def calculate
    @result = VectorCalculatorService.new(params).call
    render "pages/home"
  end
end
