function [extractValue ,S11MaxMin ,S22MaxMin ,S12MaxMin,MaxStressData,MinStressData]= extract_5EigenFrequencies_frequencyAnalysis(fullFilePath)

filetext = fileread(fullFilePath);
stringNewlineSplit = splitlines(filetext);
idxEigenMode = find(contains(stringNewlineSplit,'MODE NO'));
eigenValData=stringNewlineSplit(idxEigenMode(1):idxEigenMode(2)-3);

EigenValLine=eigenValData{5};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
firstEigenValue=str2double(EigenValLine{2});
firstEigenFreq=str2double(EigenValLine{4});


EigenValLine=eigenValData{6};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
SecondEigenValue=str2double(EigenValLine{2});
SecondEigenFreq=str2double(EigenValLine{4});



EigenValLine=eigenValData{7};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
ThirdEigenValue=str2double(EigenValLine{2});
ThirdEigenFreq=str2double(EigenValLine{4});


EigenValLine=eigenValData{8};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
FourthEigenValue=str2double(EigenValLine{2});
FourthEigenFreq=str2double(EigenValLine{4});



EigenValLine=eigenValData{9};
EigenValLine=split(EigenValLine,' ');
EigenValLine=EigenValLine(~cellfun('isempty',EigenValLine));
FifthEigenValue=str2double(EigenValLine{2});
FifthEigenFreq=str2double(EigenValLine{4});

%extractValue=[firstEigenValue  SecondEigenValue  ThirdEigenValue FourthEigenValue FifthEigenValue];
extractValue=[firstEigenFreq   SecondEigenFreq   ThirdEigenFreq  FourthEigenFreq  FifthEigenFreq ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MaxStressData=[];
MinStressData=[];

idxMax=find(contains(stringNewlineSplit,'MAXIMUM        '));
linesWithMaxData=stringNewlineSplit(idxMax);

for i=1:length(linesWithMaxData)
    
    stepMaxData=linesWithMaxData{i};
    splitStepMaxData=split(stepMaxData);
    S11=str2double(splitStepMaxData{3});
    S22=str2double(splitStepMaxData{4});
    S12=str2double(splitStepMaxData{5});
    MaxStresses= [  S11 S22 S12] ;
    MaxStressData= [MaxStressData; MaxStresses];
end

idxMin=find(contains(stringNewlineSplit,'MINIMUM        '));
linesWithMinData=stringNewlineSplit(idxMin);


for i=1:length(linesWithMinData)
    
    stepMaxData=linesWithMinData{i};
    splitStepMaxData=split(stepMaxData);
    S11=str2double(splitStepMaxData{3});
    S22=str2double(splitStepMaxData{4});
    S12=str2double(splitStepMaxData{5});
    MinStresses= [  S11 S22 S12] ;
    MinStressData= [MinStressData; MinStresses];
    
end

MaxS11Data=MaxStressData(:,1);
MaxS22Data=MaxStressData(:,2);
MaxS12Data=MaxStressData(:,3);

MinS11Data=MinStressData(:,1);
MinS22Data=MinStressData(:,2);
MinS12Data=MinStressData(:,3);




[MaxS11,posMaxS11]=max(MaxS11Data);
[MaxS22,posMaxS22]=max(MaxS22Data);
[MaxS12,posMaxS12]=max(MaxS12Data);

[MinS11,posMinS11]=min(MinS11Data);
[MinS22,posMinS22]=min(MinS22Data);
[MinS12,posMinS12]=min(MinS12Data);

S11MaxMin=[MaxS11  MinS11 posMaxS11  posMinS11];
S22MaxMin=[MaxS22  MinS22 posMaxS22  posMinS22];
S12MaxMin=[MaxS12  MinS12 posMaxS12  posMinS12];


disp('S11     S22     S12')
MaxStressData

disp('S11     S22     S12')
MinStressData

 end