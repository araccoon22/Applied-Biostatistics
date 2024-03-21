# ANOVA
#You should model the Flavor score as a function of the explanatory factors
#(i.e. leave out Texture score and Moistness score)

url_data = 'http://users.stat.ufl.edu/~winner/data/potato.dat'
potato = read.table(url_data, header = FALSE) 
new_column_names <- c("Area", "Temperature", "Size","Storage", "Cooking", "Texture", "Flavor", "Moistness") 
names(potato) = new_column_names
potato = potato[, !colnames(potato) %in% c("Texture", "Moistness")]
potato$Area <- potato$Area - 1
potato$Temperature <- potato$Temperature - 1
potato$Size <- potato$Size - 1

potato$Area <- factor(potato$Area)
potato$Temperature <- factor(potato$Temperature)
potato$Size <- factor(potato$Size)

potato$Storage <- factor(potato$Storage, levels = c(1, 2, 3, 4),  ordered = TRUE)
potato$Cooking <- factor(potato$Cooking, levels = c(1, 2, 3, 4,5))


tapply(potato$Flavor, list(potato$Area, potato$Temperature, potato$Size, potato$Storage, potato$Cooking), mean)
plot.design(potato)


anova <- aov(Flavor ~ Cooking*Storage, data=potato)
summary(anova)
coef(anova)
options("contrasts")
levels(potato$Cooking)
levels(potato$Storage)
