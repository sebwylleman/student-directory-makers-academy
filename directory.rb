@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end


def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def input_students
  puts "Please enter the students and cohorts of the students, separated by a comma"
  puts "To finish, just hit return twice"
  input = gets.chomp
  input = input.delete_suffix("\n")
  while !input.empty? do
    name, cohort = input.split(/\s*,\s*/)
    cohort == nil ? cohort = "november".to_sym : cohort
    @students << {name: name, cohort: cohort, hobbies: "----"}
    puts "Now we have #{@students.count} students"
    input = gets.chomp
    input = input.delete_suffix("\n")
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print_student_list
  students_by_cohort = @students.group_by {|student| student[:cohort]}
  students_by_cohort.each do |cohort, student|
    student.each_with_index do |student, index|
      puts "#{student[:name]} (#{student[:cohort]} cohort) hobbies: #{student[:hobbies]}".center(10)
    end
  end
  students_by_cohort
end

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  else 
    puts "We have #{@students.count} great student"
  end
end

interactive_menu()