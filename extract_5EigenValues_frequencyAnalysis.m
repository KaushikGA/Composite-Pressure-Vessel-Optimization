 function extractValue= extract_5EigenValues_frequencyAnalysis(fullFilePath)




filetext = fileread(fullFilePath);
stringNewlineSplit = splitlines(filetext);
idxEigenMode = find(contains(stringNewlineSplit,'MODE NO'));
eigenValData=stringNewlineSplit(idxEigenMode(1):idxEigenMode(2)-3);

EigenValLine=eigenValData{5};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
firstEigenValue=str2double(EigenValLine{2});



EigenValLine=eigenValData{6};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
SecondEigenValue=str2double(EigenValLine{2});




EigenValLine=eigenValData{7};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
ThirdEigenValue=str2double(EigenValLine{2});



EigenValLine=eigenValData{8};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
FourthEigenValue=str2double(EigenValLine{2});




EigenValLine=eigenValData{9};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
FifthEigenValue=str2double(EigenValLine{2});


extractValue=[firstEigenValue  SecondEigenValue  ThirdEigenValue FourthEigenValue FifthEigenValue];


 end