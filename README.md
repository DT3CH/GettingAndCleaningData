# GettingAndCleaningData
The run_Analysis script combines the data from the test files of the data set , filters out all data except the std and mean data.  Then it uses the features.txt data to name the columns of the test X_test data.  Finally it combines the ID numbers, test group identifier, std and mean measurements into a new data set. testData

The script then applies these same steps do the train datasets resulting in train_Data
finally the two datasets are merged into a new UCI dataset only recording the std and mean values from the original archive.
