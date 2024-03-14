# ANOVA
#You should model the Flavor score as a function of the explanatory factors
#(i.e. leave out Texture score and Moistness score)

url_data = 'http://users.stat.ufl.edu/~winner/data/potato.dat'
potato = read.table(url_data, header = FALSE) 
new_column_names <- c("Area", "Temperature", "Size","Storage", "Cooking", "Texture", "Flavor", "Moistness") 
names(potato) = new_column_names
potato = potato[, !colnames(potato) %in% c("Texture", "Moistness")]
