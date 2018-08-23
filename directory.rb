require 'date'

def get_input(prompt)
  puts prompt
  gets.chomp
end

def get_cohort
  while true do
    cohort = get_input("Which cohort does the student belong to?")
    if cohort.empty? 
      # if no month is entered or it is unrecognised then
      # default the month to the current month
      cohort = Date.today.strftime("%B")
      puts "Cohort has defaulted to this month: #{cohort}"
      return cohort.downcase.to_sym
    end
    if Date::MONTHNAMES.include?(cohort.capitalize)
      # a valid month was entered so convert it to a symbol
      return cohort.downcase.to_sym
    end
  end
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
    # get the cohort
    cohort = get_cohort
    # get the student's country of birth
    country = get_input("Which country were they born in?")
    # get the student's height
    height = get_input("How high are they in metres? (e.g. 1.75)")
    # get the student's hobbies
    hobbies = get_input("What are their hobbies? (e.g. tennis, football, art)")
    # add the student hash to the array
    students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies.split(", ")}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = get_input("Enter the next student's name (or hit return to finish)")
  end
  # return the array of students
  students
end

def get_header
  # returns an array containing the header contents
  header = ["The students of Villain Academy",
            "-------------------------------"]
end

def get_footer(names)
  "Overall, we have #{names.count} great students"
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

def print_student_list(students, header = true, footer = true, cohort_headings = true, numbered_list = true)
  student_list = []
  cohort_heading = ""
  if header 
    student_list << get_header
  end
  students.each_with_index do |student, index|
    if cohort_headings    
      cohort = student[:cohort].to_s.capitalize
      if cohort_heading != cohort
        cohort_heading = cohort
        student_list << cohort_heading
        student_list << "-" * cohort_heading.length
      end
    end
    if numbered_list
      list_item = "#{index + 1}. "
    else
      list_item = ""
    end
    list_item << "#{student[:name]} "
    list_item << "- #{student[:country]} "
    list_item << "(#{student[:cohort]} cohort, "
    list_item << "#{student[:height]}m, "
    list_item << "likes #{student[:hobbies].join(", ")})"
    student_list << list_item
  end
  if footer
    student_list << get_footer(students)
  end
  student_list.flatten!
  puts student_list
  puts centre_contents(student_list)
end

def order_students_by_cohort(students)
  # order the list of students by cohort
  # order is determined by the order of months in the year
  # as defined by Date::MONTHNAMES
  students.sort { |a, b|
    Date::MONTHNAMES.index(a[:cohort].to_s.capitalize) <=> Date::MONTHNAMES.index(b[:cohort].to_s.capitalize)
  }
end

# nothing happens until we call the methods
students = input_students
students = filter_students_by_first_letter(students, "J")
students = filter_students_by_length_of_name(students, 12)
students = order_students_by_cohort(students)
print_student_list(students)
