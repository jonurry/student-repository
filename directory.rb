require 'date'

@students = [] # an empty array accessible to all methods

def get_input(prompt)
  puts prompt
  # use gsub instead of chomp to remove carriage returns
  gets.gsub(/[\r\n]+$/, "")
  # gets.chomp
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
    @students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies.split(", ")}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = get_input("Enter the next student's name (or hit return to finish)")
  end
end

def get_header
  # returns an array containing the header contents
  header = ["The students of Villain Academy",
            "-------------------------------"]
end

def get_footer
  if @students.count === 1
    "Overall, we have 1 great student"
  else
    "Overall, we have #{@students.count} great students"
  end
end

def centre_contents(student_list)
  centred_content = []
  # work out the longest string in the array
  max_length = student_list.max { |a, b| a.length <=> b.length }.length
  # centre all strings based on the longest string
  student_list.each do |student|
    centred_content << student.center(max_length)
  end
  centred_content
end

def filter_students_by_first_letter(letter)
  # filter students whose names begin with 'letter'
  @students.select { |student| student[:name].start_with?(letter) }
end

def filter_students_by_length_of_name(length)
  # filter students whose name is less than 'length' characters
  @students.select { |student| student[:name].length < length }
end

def print_student_list(header = true, footer = true, cohort_headings = true, numbered_list = true)
  if @students.count > 0
    student_list = []
    cohort_heading = ""
    if header 
      student_list << get_header()
    end
    @students.each_with_index do |student, index|
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
      student_list << get_footer()
    end
    student_list.flatten!
    puts centre_contents(student_list)
  else
    puts "There are no students on the list"
  end
end

def order_students_by_cohort
  # order the list of students by cohort
  # order is determined by the order of months in the year
  # as defined by Date::MONTHNAMES
  @students.sort { |a, b|
    Date::MONTHNAMES.index(a[:cohort].to_s.capitalize) <=> Date::MONTHNAMES.index(b[:cohort].to_s.capitalize)
  }
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items later
end

def process(selection)
  case selection
  when "1"
    students = input_students()
    students = order_students_by_cohort()
  when "2"
    print_student_list()
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    print_menu()
    # 2. read the input and save it to a variable
    selection = gets.chomp
    # 3. do what the user has asked
    process(selection)
  end
end

# nothing happens until we call the methods
# students = input_students
# students = filter_students_by_first_letter(students, "J")
# students = filter_students_by_length_of_name(students, 12)
# students = order_students_by_cohort(students)
# print_student_list(students)

interactive_menu()