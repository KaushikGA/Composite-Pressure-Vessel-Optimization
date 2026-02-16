clc; clear all; close all;

Initialize_optimizer
rng default
load C:\Abaqus_temp\ICAM\Scenarios\case7_barkanov_iter5\OptimizerRuns\Barkanov_30\Data_Folder\matbackup_30.mat


mostAdvancedGenID=length(optRec.meanTopPerformances)-1;
performanceLog2=struct();
for i=1:length(optRec.meanTopPerformances)
identifierString=['gen_' num2str(i-1) '_perf'];
performanceLog2.(identifierString)=optRec.performanceLog.(identifierString);

end
optRec.performanceLog=performanceLog2;
allGenerationsRecorded=fieldnames(optRec.performanceLog);
mostAdvancedGeneration=allGenerationsRecorded{end};
splitTextAdvGen=split(mostAdvancedGeneration,'_');
mostAdvancedGenID=str2num(splitTextAdvGen{2});




optRec.objectiveHistory=optRec.objectiveHistory(1:mostAdvancedGenID+1);
optRec.meanTopPerformances=optRec.meanTopPerformances(1:mostAdvancedGenID+1);

dataMatrix=optRec.performanceLog.([mostAdvancedGeneration]);
[dmRows,dmCols]=size(dataMatrix);
[~,sortOrder]=sort(-dataMatrix(dmRows,:));
dataMatrix=dataMatrix(:,sortOrder);
printGenerationPerformance ( optRec , ModelProperties   )

disp('previous generations parsed, now starting - ')
refBinaryVector=zeros(1,length(ModelProperties.allClusters)+1)';
evaluated_RefValues=getReferenceSolution ( ModelProperties, refBinaryVector , 9999 ,...
    dirPaths)

backupMAT=fullfile(dirPaths.simulationWorkspaceDirectory,['matbackup_' int2str(mostAdvancedGenID)]);
% optRec2=optRec;
%     optRec2.performanceLogFull=[];
% 	save(backupMAT,'optRec2', 'ModelProperties');




for iter=mostAdvancedGenID+1:optInitVars.maxIter
    genId=iter;
   
    
    newGen= getNewGeneration (dataMatrix,optInitVars, optRec , ModelProperties);
    
    dataMatrix_newGen=12345;
    while dataMatrix_newGen==12345
    [dataMatrix_newGen,fullGenData]=run_generation ( ModelProperties, newGen , genId , dirPaths,evaluated_RefValues);
    end
    [ngRows,ngCols]=size(dataMatrix_newGen);
    
    dataMatrix(1:ngRows,1:ngCols)=dataMatrix_newGen;
    
    %--------------------------------------------------------------------------
    
    
    
    
    [~,sortOrder]=sort(-dataMatrix(dmRows,:));
    dataMatrix=dataMatrix(:,sortOrder);
    optRec=recordPopulationPerformance(dataMatrix, optRec,fullGenData,genId);
    
    thisDir=cd;
    cd(dirPaths.simulationWorkspaceDirectory);
    delete *.dat
    backupMAT=fullfile(dirPaths.simulationWorkspaceDirectory,['matbackup_' int2str(genId)]);
    cd(thisDir);
    
    
   
    if mod(genId,50)==0
    getEvolutionaryINPs (dirPaths,optRec,ModelProperties);
    end
    
    if mod(genId,10)==0
    close all
    optRec2=optRec;
    optRec2.performanceLogFull=[];
	save(backupMAT,'optRec2', 'ModelProperties');
    getDiagnosticPlots (optRec );
    RecycledMaterialProgressionPlots= getRecycledMaterialProgressionPlots( optRec , ModelProperties   );
    end
    printGenerationPerformance ( optRec , ModelProperties   )
    diary off
    
    
end


