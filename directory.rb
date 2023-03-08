require 'csv'

@students = [] # accessible to all methods

# Un-comment to show this file's source code to the console
# filename = __FILE__
# File.open(filename, "r") do |file|
#     puts file.read
# end

def try_load_students
  puts "Enter filename to load, press enter for default"
  filename = gets.chomp
  if filename.nil?
     load_students
     puts "Loaded #{@students.count} students from default file:'students.csv'"
  elsif File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.strip.to_sym}
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |line|
    name, cohort = line
    add_student(name, cohort)
  end
end

def input_students
  puts "Please enter the names and cohorts of the students, separated by a comma"
  puts "To finish, just hit return twice"

  input = gets.chomp
  while !input.empty? do
    name, cohort = input.split(/\s*,\s*/)
    cohort == nil ? cohort = "november".to_sym : cohort
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    input = gets.chomp
  end
end

def save_students
  puts "enter file name followed by .csv extension"
  filename = gets.chomp
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the student list"
  puts "5. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    puts "option 1 selected"
    input_students
  when "2"
    puts "option 2 selected"
    show_students
  when "3"
    puts "option 3 selected"
    save_students
  when "4"
    puts "option 4 selected"
    try_load_students
  when "5"
    puts "Goodbye"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

interactive_menu