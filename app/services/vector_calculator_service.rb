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
    str = @params[key].to_s.strip
    raise ArgumentError, "Поле ввода не должно быть пустым" if str.empty?

    # Разбиваем по любому сочетанию запятых и пробелов:
    parts = str.split(/[,\s]+/)

    parts.each do |cell|
      unless numeric_string?(cell)
        raise ArgumentError, "Неправильный элемент «#{cell}»: ожидается число"
      end
    end

    parts.map(&:to_f)
  end


  def numeric_string?(s)
    /\A[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?\z/ === s
  end

  def parsed_matrix
    matrix = @params[:matrix].to_s.strip

    matrix.lines.map do |row|
      row.split.each do |cell|
        unless numeric_string?(cell)
          raise ArgumentError, "Неправильный элемент «#{cell}». ожидается число"
        end
      end
      row.split.map(&:to_f)
    end
  end
end
