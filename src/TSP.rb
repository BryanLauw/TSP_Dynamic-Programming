def read_matrix(file_name)
    file_name += ".txt"
    src = File.join("test", file_name)
    
    mat = []
  
    File.open(src, 'r') do |file|
        file.each_line do |line|
            row = line.split.map(&:to_i)
            # Add the row to the matrix
            mat << row
        end
    end  

    return mat
  end

def save(file_name, adj_matrix, result)
    file_name += ".txt"
    src = File.join("test", file_name)

    File.open(src, 'w') do |file|
        file.puts "Matriks ketetanggaan: "
        for i in adj_matrix do
            for j in i do
                file.print(j)
                file.print(' ')
            end
            file.puts
        end
        file.puts "\n"
        file.print("Jalur yang dilalui: ")
        file.puts (result[0].map {|x| x + 1}).inspect
        file.print("Jarak tempuh: ")
        file.puts result[1]
    end
end
  
def tsp(i, s, adj_matrix)
    if s.size == 1
        j = s.first
        return [[i,j,0], adj_matrix[i][j]+adj_matrix[j][0]]
    end

    rest =  [[], Float::INFINITY]

    s.each do |j|
        set = s.dup
        set.delete(j)
        rec = tsp(j, set, adj_matrix)

        rec[0].unshift(i)

        recursion_result = [rec[0], rec[1] + adj_matrix[i][j]]

        rest = [rest, recursion_result].min_by { |x| x[1] }
    end

    return rest
end

print("masukkan nama file: ")
file_name = gets.chomp
m = read_matrix(file_name)
if m.length == m[0].length
    setTemp = Set.new((1..m.length-1).to_a)
    hasil = tsp(0, setTemp, m)
    print "Jalur yang dilalui: "
    puts (hasil[0].map {|x| x + 1}).inspect
    print "Jarak: "
    puts hasil[1]

    print("Apakah ingin menyimpan pada file? (y/n) ")
    sv = gets.chomp
    if sv === 'y'
        print("Masukkan nama file penyimpanan: ")
        name = gets.chomp
        save(name, m, hasil)
    end
else
    puts "Matriks tidak valid"
end