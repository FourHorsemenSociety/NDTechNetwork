module AppHelpers

  def current_student_year
    current_time = Time.new
    return current_time.year + 1 if current_time.month >= 5
    return current_time.year
  end

end
