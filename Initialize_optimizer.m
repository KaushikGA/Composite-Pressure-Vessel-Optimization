num=clock;
global optInitVars
global dirPaths
global optRec

uniqueTimeIdentifier = [num2str(num(2)) '-' num2str(num(3)) '-' num2str(num(1)) '_'...
    num2str(num(4)) '.' num2str(num(5)) '.' num2str(num(6))];
optInitVars.runFileTimeStamp= uniqueTimeIdentifier;
%***************************************************************************
optRec.rankOfPopulation=[];
optRec.slopeHistory=[];
optRec.objectiveHistory=[];
optRec.recordOfClusters=[];
optRec.uniqueCiviliansCount=[];
optRec.populationDiary=[];
optRec.populationLog=[];
optRec.meanTopPerformances=[];
optRec.performanceLog=struct();
%***************************************************************************

dirPaths.sourceDirectory=cd;
dirPaths.clusteringDataPath=fullfile(dirPaths.sourceDirectory,'Box_PropagativeClustering',"clusterdata.mat");
mkdir('..\OptimizerRuns',optInitVars.runFileTimeStamp);
dirPaths.backupDirectory=fullfile('..\OptimizerRuns',optInitVars.runFileTimeStamp) ;
dirPaths.scriptsBackupDirectory=fullfile(dirPaths.backupDirectory,'Scripts_Folder');
mkdir(dirPaths.scriptsBackupDirectory);
fprintf('VERSION %s.m\n',optInitVars.runFileTimeStamp)
dirPaths.simulationWorkspaceDirectory=fullfile(dirPaths.backupDirectory,'Data_Folder') ;
dirPaths.initialRunDirectory=fullfile(dirPaths.backupDirectory,'Initial Run') ;
mkdir(dirPaths.initialRunDirectory);
dirPaths.matDataPath=fullfile(dirPaths.backupDirectory,'WorkspaceBackup.mat');
mkdir(dirPaths.simulationWorkspaceDirectory);
fileListm=dir('*.m');
for filenumber= 1: length(fileListm )
    sourcefile=fullfile(fileListm(filenumber).folder,fileListm(filenumber).name);
    targetfile=fullfile(dirPaths.scriptsBackupDirectory,fileListm(filenumber).name);
    copyfile(sourcefile,targetfile);
end

load(dirPaths.clusteringDataPath)
ModelProperties.desiredRecycledMaterial=0.30;
ModelProperties.fileName=char('brknv');
optInitVars.desiredRecycleMaterial=ModelProperties.desiredRecycledMaterial;
optInitVars.maxRecycleMaterial=optInitVars.desiredRecycleMaterial+0.05;
optInitVars.minRecycleMaterial=optInitVars.desiredRecycleMaterial-0.05;
optInitVars.populationSize=30;
optInitVars.populationCutoff=floor(optInitVars.populationSize*0.5);
optInitVars.maxIter=50;
optInitVars.delta=0.001;
optInitVars.counter=1;
optInitVars.mutateFlag= false;
optInitVars.checkHistoryData=true;
optInitVars.useRestarterAlgorithm=true;
optInitVars.restartFlag=false;
optInitVars.restarted=false;
optInitVars.lookInThePast=0;
optInitVars.slopeControl=5;
optInitVars.stabilizationTime=10;
optInitVars.totalParameters=length(ModelProperties.allClusters);

clear sourcefile targetfile ind num filenumber fileListm
%***************************************************************************
%fprintf('VERSION %s.m\n',optimizerInitilizationVariables.runFileTimeStamp)
%***************************************************************************