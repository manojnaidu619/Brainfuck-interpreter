
@program_data = ARGF.read.to_s
@program_space = Array.new(65536,0)   # Dealing with 2^16 data size
@data_ptr = 0
@program_length = @program_data.length
index = 0

# Function to calculate the loop length

def compute_loop_length(index)
    end_index = index
    while index < @program_length
        break if @program_data[end_index] == ']'
        end_index += 1
    end
    return end_index
end

# Driver function

def compute_program(current_char, index)
    if !current_char.nil?
        case current_char
            when "+" then @program_space[@data_ptr] += 1 if @program_space[@data_ptr] >= 0
            when "-" then @program_space[@data_ptr] -= 1 if @program_space[@data_ptr] > 0
            when "." then print @program_space[@data_ptr].chr 
            when ">" then @data_ptr += 1  
            when "<" then @data_ptr -= 1 
            when "[" then return compute_loop(index+1)      
        end 
    end   
end

# Function to compute inside the loop

def compute_loop(index)
    start_index = index
    end_index = compute_loop_length(index)
    counter = @program_space[@data_ptr]
    if counter > 0
        while index <= end_index
            current_char = @program_data[index]
            if current_char == ']'
                index = start_index-1 if @program_space[@data_ptr] != 0
            else
                compute_program(current_char, index)
            end
            index += 1
        end
    end
    return end_index+1
end

# Driver segment

while index < @program_length
    current_char = @program_data[index]
    if current_char == "["
        index = (compute_program(current_char, index))-1
    else
        compute_program(current_char, index)
    end
    index += 1
end

