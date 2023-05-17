-- Load Data from HDFS
inputFile = LOAD 'hdfs:///user/lakshmi/inputs' USING PigStorage('\t') As (name:chararray, line:chararray);

-- Fileter out the first 2 lines
ranked = RANK inputFile;
onlyDialouges = FILTER ranked BY (rank_inputFile > 2);

-- Group by name
groupByName = GROUP onlyDialouges BY name;

-- Count the number of lines by each character
names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdere = ORDER names BY no_of_lines DESC;

-- Remove the output folder 
rmf hdfs:///user/lakshmi/outputs

-- Store result in HDFS
STORE namesOrdere INTO 'hdfs:///user/lakshmi/outputs' USING PigStorage('\t');
