clear all
clc
close all
load genData50
load C:\Abaqus_temp\ICAM\Scenarios\Cases3\OptimizerRuns\5-13-2022_9.45.29.206\Data_Folder\matbackup_50.mat
rowNames={}

optRec.performanceLog.gen_50_perf(1:end-1,:) 


for i=1:15
rowNames{i}= [ 'MEM' int2str(i)]
end

EFT=table([genData(:,1) genData(:,2) genData(:,3) genData(:,4) genData(:,5)],'VariableNames',{'EF'},'RowNames',rowNames)
S11T=table([genData(:,6) genData(:,7) ],'VariableNames',{'S11'},'RowNames',rowNames)
S22T=table([genData(:,8) genData(:,9) ],'VariableNames',{'S22'},'RowNames',rowNames)
S12T=table([genData(:,10) genData(:,11) ],'VariableNames',{'S12'},'RowNames',rowNames)
ObjT=table([genData(:,12)],'VariableNames',{'Objective'},'RowNames',rowNames)
[EFT S11T S22T S12T ObjT]
bestMember=optRec.currentBestMember(1:end-1);
totalParameters=length(bestMember)
hexKey=binaryVectorToHex( bestMember' )

binVal = hexToBinaryVector(hexKey)

binaryBack=[zeros(1,(totalParameters-length(binVal))) binVal]'

sum(bestMember==binaryBack)

