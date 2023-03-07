def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Please enter the names and cohorts of the students, separated by a comma"
  puts "To finish, just hit return twice"
  students = []
  input = gets.chomp
  input = input.delete_suffix("\n")
  while !input.empty? do
    name, cohort = input.split(/\s*,\s*/)
    cohort == nil ? cohort = "november".to_sym : cohort
    students << {name: name, cohort: cohort, hobbies: "----"}
    puts "Now we have #{students.count} students"
    input = gets.chomp
    input = input.delete_suffix("\n")
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print(students)
  students_by_cohort = students.group_by {|student| student[:cohort]}
  students_by_cohort.each do |cohort, student|
    student.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort) hobbies: #{student[:hobbies]}".center(50)
    end
  end
  students_by_cohort
end

def print_footer(names)
  if names.count > 1
    puts "Overall, we have #{names.count} great students"
  else 
    puts "We have #{names.count} great student"
  end
end

interactive_menu()