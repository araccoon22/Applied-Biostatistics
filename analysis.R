url_data = 'http://users.stat.ufl.edu/~winner/data/potato.dat'
potato = read.table(url_data, header = FALSE) 
new_column_names <- c("Area", "Temperature", "Size","Storage", "Cooking", "Texture", "Flavor", "Moistness") 
names(potato) <- new_column_names
