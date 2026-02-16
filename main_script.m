baseDirectory=cd
killAllAbaqusProcesses (baseDirectory);
pause(5)
clc; clear all; close all;
diary off
Initialize_optimizer
rng default
refBinaryVector=zeros(1,length(ModelProperties.allClusters)+1)';
evaluated_RefValues=getReferenceSolution ( ModelProperties, refBinaryVector , 9999 ,...
    dirPaths)


%--------------------------------------------------------------------------
dataMatrix=initilializePopulation (optInitVars.populationSize , ModelProperties ,optRec ,optInitVars );
%--------------------------------------------------------------------------
genId=0;
[dmRows,dmCols]=size(dataMatrix);

dataMatrix_newGen=12345;
    while dataMatrix_newGen==12345
    [dataMatrix_newGen,fullGenData]=run_generation ( ModelProperties, dataMatrix , genId , dirPaths,evaluated_RefValues);
    end

dataMatrix=dataMatrix_newGen;
[~,sortOrder]=sort(-dataMatrix(dmRows,:));
dataMatrix=dataMatrix(:,sortOrder);
optRec=recordPopulationPerformance(dataMatrix, optRec,fullGenData,genId);


backupMAT=fullfile(dirPaths.simulationWorkspaceDirectory,['matbackup_' int2str(genId)]);
save(backupMAT,'optRec', 'ModelProperties');

%--------------------------------------------------------------------------
 diary off

for iter=1:optInitVars.maxIter
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





