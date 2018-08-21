def input_students
  puts "Please enter the names and details of the students"
  puts "To finish, just hit return twice at the name prompt"
  # creates an empty array
  students = []
  # get the first name
  puts "Enter student's name"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the student's country of birth
    puts "Which country were they born in?"
    country = gets.chomp
    # get the student's height
    puts "How high are they in metres? (e.g. 1.75)"
    height = gets.chomp
    # get the student's hobbies
    puts "What are their hobbies? (e.g. tennis, football, art)"
    hobbies = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, height: height, hobbies: hobbies.split(", ")}
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Enter the next student's name (or hit return to finish)"
    name = gets.chomp
  end
  # return the array of students
  students
end

def header
  # returns an array containing the header contents
  header = ["The students of Villain Academy",
            "-------------------------------"]
end

def generate_student_list(students)
  student_list = []
  counter = 0
  while counter < students.length do
    student = students[counter]
    counter += 1
    student_list << "#{counter}. #{student[:name]} - #{student[:country]} (#{student[:cohort]} cohort, #{student[:height]}m, likes #{student[:hobbies].join(", ")})"
  end
  student_list
end

def centre_contents(students)
  centred_output = []
  # work out the longest string in the array
  max_length = students.max { |a, b| a.length <=> b.length }.length
  # centre all strings based on the longest string
  students.each do |student|
    centred_output << student.center(max_length)
  end
  centred_output
end

def footer(names)
  "Overall, we have #{names.count} great students"
end

def filter_students_by_first_letter(students, letter)
  # filter students whose names begin with 'letter'
  students.select { |student| student[:name].start_with?(letter) }
end

def filter_students_by_length_of_name(students, length)
  # filter students whose name is less than 'length' characters
  students.select { |student| student[:name].length < length }
end

def print_students(students)
  student_list = []
  student_list << header
  student_list << generate_student_list(students)
  student_list << footer(students)
  student_list.flatten!
  puts centre_contents(student_list)
end

# nothing happens until we call the methods
students = input_students
students = filter_students_by_first_letter(students, "J")
students = filter_students_by_length_of_name(students, 12)
print_students(students)
