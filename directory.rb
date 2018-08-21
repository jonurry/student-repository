def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # creates an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villain Academy"
  puts "-------------------------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def filter_students_by_first_letter(students, letter)
  # filter students whose names begin with 'letter'
  students.select { |student| student[:name].start_with?(letter) }
end

def filter_students_by_length_of_name(students, length)
  # filter students whose name is less than 'length' characters
  students.select { |student| student[:name].length < length }
end

# nothing happens until we call the methods
students = input_students
students = filter_students_by_first_letter(students, "J")
students = filter_students_by_length_of_name(students, 12)
print_header
print(students)
print_footer(students)
