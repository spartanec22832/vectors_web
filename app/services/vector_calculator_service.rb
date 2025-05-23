
class VectorCalculatorService
  def initialize(user, params)
    @user     = user
    @params    = params
    @operation = params[:operation].to_s
  end

  def call
    case @operation
    when "determinant"
      mat = @user.matrices.create!(matrix_data: parsed_matrix)
      result = Vectors.determinant(parsed_matrix)
      Operation.create!(
        user:           @user,
        matrix:         mat,
        operation_type: :determinant,
        result_data:    { value: result, inputs: parsed_matrix }
      )
      AuditLog.create!(
        user:           @user,
        event_type:     :operation,
        payload:        { value: result, inputs: mat }
      )
      result
    when "dot"
      v1, v2 = parsed_vector(:vector1), parsed_vector(:vector2)
      vec = @user.vectors.create!(coords: { vector1: v1, vector2: v2 })
      result = Vectors.scalar_prod(v1, v2)
      Operation.create!(
        user:           @user,
        vector:         vec,
        operation_type: :dot_product,
        result_data:    { value: result, inputs: { v1: v1, v2: v2 } }
      )
      AuditLog.create!(
        user:           @user,
        event_type:     :operation,
        payload:        { value: result, inputs: { v1: v1, v2: v2 } }
      )
      result
    when "cross"
      v1, v2 = parsed_vector(:vector1), parsed_vector(:vector2)
      vec = @user.vectors.create!(coords: { vector1: v1, vector2: v2 })
      result = Vectors.cross_prod(v1, v2)
      Operation.create!(
        user:           @user,
        vector:         vec,
        operation_type: :cross_product,
        result_data:    { value: result, inputs: { v1: v1, v2: v2 } }
      )
      AuditLog.create!(
        user:           @user,
        event_type:     :operation,
        payload:        { value: result, inputs: { v1: v1, v2: v2 } }
      )
      result
    else
      raise ArgumentError, "Неизвестная операция: #{@operation}"
    end
  end

  private

  def parsed_vector(key)
    str = @params[key].to_s.strip
    raise ArgumentError, "Поле «#{key}» не должно быть пустым" if str.empty?

    parts = str.split(/[,\s]+/)
    parts.each do |cell|
      unless /\A[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?\z/ === cell
        raise ArgumentError, "Неправильный элемент «#{cell}»: ожидается число"
      end
    end

    parts.map(&:to_f)
  end

  def parsed_matrix
    lines = @params[:matrix].to_s.strip.lines
    raise ArgumentError, "Поле «matrix» не должно быть пустым" if lines.empty?

    lines.map do |row|
      cells = row.split
      cells.each do |cell|
        unless /\A[+-]?(\d+\.?\d*|\.\d+)([eE][+-]?\d+)?\z/ === cell
          raise ArgumentError, "Неправильный элемент «#{cell}»: ожидается число"
        end
      end
      cells.map(&:to_f)
    end
  end
end
