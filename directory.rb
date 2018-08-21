def get_input(prompt)
  puts prompt
  gets.chomp
end

def input_students
  puts "Please enter the names and details of the students"
  puts "To finish, just hit return twice at the name prompt"
  # creates an empty array
  students = []
  # get the first name
  name = get_input("Enter student's name")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the student's country of birth
    country = get_input("Which country were they born in?")
    # get the student's height
    height = get_input("How high are they in metres? (e.g. 1.75)")
    # get the student's hobbies
    hobbies = get_input("What are their hobbies? (e.g. tennis, football, art)")
    # add the student hash to the array
    students << {name: name, cohort: :november, country: country, height: height, hobbies: hobbies.split(", ")}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = get_input("Enter the next student's name (or hit return to finish)")
  end
  # return the array of students
  students
end

def header
  # returns an array containing the header contents
  header = ["The students of Villain Academy",
            "-------------------------------"]
end

def footer(names)
  "Overall, we have #{names.count} great students"
end

def numbered_list(students)
  student_list = []
  counter = 0
  while counter < students.length do
    student = students[counter]
    counter += 1
    list_item = "#{counter}. #{student[:name]}"
    list_item << " - #{student[:country]}"
    list_item << " (#{student[:cohort]} cohort,"
    list_item << " #{student[:height]}m,"
    list_item << " likes #{student[:hobbies].join(", ")})"
    student_list << list_item
  end
  student_list
end

def centre_contents(students)
  centred_content = []
  # work out the longest string in the array
  max_length = students.max { |a, b| a.length <=> b.length }.length
  # centre all strings based on the longest string
  students.each do |student|
    centred_content << student.center(max_length)
  end
  centred_content
end

def filter_students_by_first_letter(students, letter)
  # filter students whose names begin with 'letter'
  students.select { |student| student[:name].start_with?(letter) }
end

def filter_students_by_length_of_name(students, length)
  # filter students whose name is less than 'length' characters
  students.select { |student| student[:name].length < length }
end

def print_student_list(students)
  student_list = []
  student_list << header
  student_list << numbered_list(students)
  student_list << footer(students)
  student_list.flatten!
  puts centre_contents(student_list)
end

# nothing happens until we call the methods
students = input_students
students = filter_students_by_first_letter(students, "J")
students = filter_students_by_length_of_name(students, 12)
print_student_list(students)
