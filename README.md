# Getting and Cleaning Data Course Project

## How to run
Download the data (actual commands may depend on your Operating System)

    wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Unpack the data into the current folder

    unzip -j getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Check training data folder is direct child of the current

    $ ls | grep train
    train

## Details about the tidy dataset
For the transformations & data source see [CodeBook.md](CodeBook.md)

End result is [aggregated.txt](aggregated.txt)
