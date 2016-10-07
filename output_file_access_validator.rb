# Responsible for validating if output file is accessible to user
class OutputFileAccessValidator
  def initialize(output_file_path)
    @output_file_path = output_file_path
  end

  def access_granted?
    return true unless File.exist?(@output_file_path)
    ask_user_for_access
  end

  private

  def ask_user_for_access
    puts 'Output file already exists. Overwrite? (y/n)'
    decision = nil
    while decision.nil?
      decision_text = gets.chomp
      decision = true if decision_text == 'y'
      decision = false if decision_text == 'n'
    end
    decision
  end
end
