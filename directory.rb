def input_students
  puts "Please enter the names and cohorts of the students, separated by a comma"
  puts "To finish, just hit return twice"
  students = []
  input = gets.chomp
  while !input.empty? do
    name, cohort = input.split(/\s*,\s*/)
    cohort == nil ? cohort = "november".to_sym : cohort
    students << {name: name, cohort: cohort, hobbies: "----"}
    puts "Now we have #{students.count} students"
    input = gets.chomp
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
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header()
print(students)
print_footer(students)