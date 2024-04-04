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
levels(potato$Area) <- c("Southern", "Central")

potato$Temperature <- factor(potato$Temperature)
levels(potato$Temperature) <- c("75F", "40F")

potato$Size <- factor(potato$Size)
levels(potato$Size) <- c("Large", "Medium")

potato$Storage <- factor(potato$Storage, levels = c(1, 2, 3, 4),  ordered = TRUE)
levels(potato$Storage) <- c("0mth", "2mth", "4mth", "6mth")


potato$Cooking <- factor(potato$Cooking, levels = c(1, 2, 3, 4,5))
levels(potato$Cooking) <- c("Boil", "Steam", "Mash", "350°F", "450°F")


anova <- aov(Flavor ~ Cooking*Storage + Temperature*Storage + Area*Storage + Cooking*Temperature + Cooking*Area + Area*Temperature, data=potato)

summary(anova)

coef(anova)
options("contrasts")
levels(potato$Cooking)
levels(potato$Storage)


tukey_Storage <- TukeyHSD(anova, "Storage")
tukey_Storage
plot(tukey_Storage)
#for the comparison between "2mth" and "0mth" storage durations, 
# the mean Flavor score for "2mth" storage is 0.2200 higher than for "0mth" storage.
#p-value of 0.0000112, which is less than the significance level (usually 0.05). 
#Therefore, we would reject the null hypothesis and conclude that there is a statistically 
#significant difference in mean Flavor score between "2mth" and "0mth" storage durations.
#Similarly, for "4mth-0mth" and "6mth-0mth" comparisons, the p-values are both less than 0.05, 
# indicating statistically significant differences in mean Flavor scores between these storage durations.
# On the other hand, for "4mth-2mth", "6mth-2mth" "6mth-4mth" comparisons, the p-values are both greater 
# than 0.05. Thus, we fail to reject the null hypothesis and conclude that there is no statistically 
# significant difference in mean Flavor scores between these pairs of storage durations.


tukey_Temperature <- TukeyHSD(anova, "Temperature")
tukey_Temperature
plot(tukey_Temperature)
# the mean Flavor score for "40F" temperature is 0.165 lower than for "75F" temperature.

tukey_Cooking <- TukeyHSD(anova, "Cooking")
tukey_Cooking
plot(tukey_Cooking)
#Mean flavor score for "Mash" is significantly higher than "Steam" and "350°F".
#Mean flavor score for "350°F" is significantly higher than "Steam".
#Mean flavor score for "450°F" is significantly lower than "Mash" and "350°F".

tukey_Area <- TukeyHSD(anova, "Area")
tukey_Area
plot(tukey_Area)
#Mean flavor score for "Central" is significantly higher than "Southern".

