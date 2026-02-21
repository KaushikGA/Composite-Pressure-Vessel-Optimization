function extractValue= extract_1stEigenValue(fullFilePath)
% clc
% clear all
% close all

%fullFilePath=['Z:\02_Group_members\33_Publications\2022_10_ICAS_Stockholm\Scripts\ElementClustering\TestWorkAbaqus\Overwritten.dat'];


filetext = fileread(fullFilePath);
stringNewlineSplit = splitlines(filetext);
idxEigenMode = find(contains(stringNewlineSplit,'MODE NO'));
idxAnalysisComplete = find(contains(stringNewlineSplit,'THE ANALYSIS HAS BEEN COMPLETED'));

eigenValData=stringNewlineSplit(idxEigenMode:end);
firstEigenValLine=eigenValData{4};
firstEigenValLine=split(firstEigenValLine,' ');
firstEigenValLine=firstEigenValLine(~cellfun('isempty',firstEigenValLine));
firstEigenValue=str2double(firstEigenValLine{2});
extractValue=firstEigenValue;
if firstEigenValue<0
    SecondEigenValLine=eigenValData{5};
    SecondEigenValLine=split(SecondEigenValLine,' ');
    SecondEigenValLine=SecondEigenValLine(~cellfun('isempty',SecondEigenValLine));
    SecondEigenValue=str2double(SecondEigenValLine{2});
    extractValue=SecondEigenValue;
end


end