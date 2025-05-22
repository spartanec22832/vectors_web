# app/services/vector_calculator_service.rb
class VectorCalculatorService
  def initialize(params)
    @params = params
    @operation = params[:operation].to_s
  end

  # Основной метод: вызывает нужный метод из гема Vectors
  # и возвращает результат (число, массив и т.д.)
  def call
    case @operation
    when "determinant"
      Vectors.determinant(parsed_matrix)

    when "dot"
      Vectors.scalar_prod(parsed_vector(:vector1),
                          parsed_vector(:vector2))

    when "cross"
      Vectors.cross_prod(parsed_vector(:vector1),
                         parsed_vector(:vector2))

    else
      raise ArgumentError, "Неизвестная операция: #{@operation}"
    end
  end

  private

  def parsed_vector(key)
    str = @params[key].to_s
    return nil if str.empty?

    str.split(",").map(&:to_f)

  end

  def parsed_matrix
    str = @params[:matrix].to_s.strip
    return nil if str.empty?

    str.lines.map do |row|
      row.split.map(&:to_f)
    end
  end
end
