# GettingAndCleaningData
The Run_Analysis script is used to combine various files containing raw data and return a new file comprised of a single data set with the mean values according to activity and subject.

The file will take the data sets in the workding directory and read in all the data into separate tables
after reading in all the data the files will be bound by ROW , and variable so for example x_train with x_test to create new sets in tables x_set and y_set and subject_set.

After the binding of data the features.txt file and the grep function is applied to obtain only variables that report a STD or MEAN value.
The new vector of filtered variables is applied as column names to the x_set table to produce a new table that only has the raw data for STD or MEAN value variables.

Next the column names and subject activities are replaced using the names supplied in the activity labels file.

With all proper formating and subsetting done the tables are all merged into a new single table data set.

Following this the ddply function is used to subset and apply the colMeans function to the new table by activity and subject and write a file UCIdata.txt which is the new tidy data set.
