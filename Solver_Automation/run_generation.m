function [evaluated_dataMatrix,GenData]=run_generation ( ModelProperties, dataMatrix , genId , dirPaths, refEFvalues)

baseDirectory=cd;
%--------------------------------------------------------------------------
%create INPs
[totalRows,totalColmns]=size(dataMatrix);
populationSize=totalColmns;
totalElements=length(ModelProperties.allClusters);


simulationFolder=fullfile(dirPaths.simulationWorkspaceDirectory,['GEN_' int2str(genId)]);
LOGFile='GEN_'+string(genId)+'_printRecord.log';
diaryFile=  fullfile( dirPaths.simulationWorkspaceDirectory , LOGFile);
diary(diaryFile)
if exist(simulationFolder,'dir')
    forceDeleteString="rmdir /s /q "+simulationFolder;
    system(forceDeleteString);
    pause(5);
    mkdir(simulationFolder);
else
    mkdir(simulationFolder);
end

for personID=1:populationSize
    binaryMember=dataMatrix(1:totalElements,personID);
    
    FileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(genId)+'_ID'+string(personID);
    INPfileName=FileName+'.inp';
    INPfullPath=fullfile(simulationFolder,INPfileName );
    
    
    writeINP (INPfullPath,...
        binaryMember,...
        ModelProperties     );
end


%--------------------------------------------------------------------------
%run INPs
cd(simulationFolder)

f = waitbar(0, 'Starting');
fileListLCK=dir('*.lck');
for personID=1:populationSize
    waitbar(personID/populationSize, f, sprintf('abaqus jobs submitted: %d %% \n Currently running: %d ', floor(personID*100/populationSize),length(fileListLCK) ) );
    FileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(genId)+'_ID'+string(personID);
    INPfileName=char(FileName);
    fileListLCK=dir('*.lck');
    fileListDMP=dir('*.dmp');
    fileListexp=dir('*.exception');
    %fileListFailedODB=dir('*.odb_f');
    system(['abaqus job=' INPfileName ' cpus=4' ]);
    pause(1)
    fileListLCK=dir('*.lck');
    while( length( fileListLCK)>2  )
        fileListLCK=dir('*.lck');
        fileListDMP=dir('*.dmp');
        fileListexp=dir('*.exception');
       % fileListFailedODB=dir('*.odb_f');
        pause(0.5)
    end
    
    
    
     if(~isempty(fileListDMP) || ~isempty(fileListexp) )%|| ~isempty(fileListFailedODB) )
        close(f);
        cd(baseDirectory)
        killAllAbaqusProcesses (baseDirectory);
        fprintf('\n*****\tGENERATION #%d simulation encountered error, attempting to restart in few seconds\t***********',genId);
        pause(5);
        
        evaluated_dataMatrix=12345;
        GenData=0;
        return;
    end
    
    
    
    
end


fileListLCK=dir('*.lck');

while ~isempty(fileListLCK)
    waitbar(1, f, sprintf(' Currently running: %d ',length(fileListLCK) ) );
    
    fileListLCK=dir('*.lck');
    %fileListFailedODB=dir('*.odb_f');
    fileListDMP=dir('*.dmp');
    pause(0.5)
    fileListexp=dir('*.exception');
    pause(0.5)
    if(~isempty(fileListDMP) || ~isempty(fileListexp) )%|| ~isempty(fileListFailedODB))
        close(f);
        cd(baseDirectory)
        killAllAbaqusProcesses (baseDirectory);
        fprintf('\n*****\tGENERATION #%d simulation encountered error, attempting to restart in few seconds\t***********',genId);
        pause(5);
        
        evaluated_dataMatrix=12345;
        GenData=0;
        return;
    end
    
end





close(f)
cd(baseDirectory)
pause(0.5);

for personID=1:populationSize
    
    FileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(genId)+'_ID'+string(personID);
    DATfileName=FileName+'.dat';
    DATfilefullPath=fullfile(simulationFolder,DATfileName );
    if exist(DATfilefullPath,'file' )
        continue
    else
        pause(10)
        if exist(DATfilefullPath,'file' )
            continue
        else
            
            cd(baseDirectory)
            killAllAbaqusProcesses (baseDirectory);
            fprintf('\n*****\tGENERATION #%d simulation DAT Files not available, attempting to restart in few seconds\t***********',genId);
            pause(5);
            
            evaluated_dataMatrix=12345;
            GenData=0;
            return;
            
            
        end
        
    end
    
end


f = waitbar(0, 'Reading results');
pause(0.5);
%--------------------------------------------------------------------------
%read data from .dat and %fill evaluated_dataMatrix
%--------------------------------------------------------------------------
evaluated_dataMatrix=dataMatrix;
GenData=struct();
for personID=1:populationSize
    waitbar(personID/populationSize, f, sprintf('Reading results : %d % complete ', floor(personID*100/populationSize) ) );
    FileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(genId)+'_ID'+string(personID);
    DATfileName=FileName+'.dat';
    DATfilefullPath=fullfile(simulationFolder,DATfileName );
    disp ([ 'Member-' char(int2str(personID)) '-Generation-' char(int2str(genId)) ])
    [extractedEFValues ,S11MaxMin ,S22MaxMin ,S12MaxMin,MaxStressData,MinStressData]=extract_5EigenFrequencies_frequencyAnalysis(DATfilefullPath);
    binaryMember=evaluated_dataMatrix (:,personID  );
    hexIdentifier=  ['G' char(int2str(genId)) 'ID' char(binaryVectorToHex (binaryMember(1:totalElements)'))];
    
    recycledMaterialEstimate= getRecycledMaterialEstimate  (binaryMember , ModelProperties   );
    disp('***********************************************************************************')
    disp(hexIdentifier)
    disp('***********************************************************************************')
    
    objectiveVal=getObjectiveVal (refEFvalues,extractedEFValues ,...
        S11MaxMin ,S22MaxMin ,S12MaxMin ,MaxStressData,MinStressData,...
        recycledMaterialEstimate,ModelProperties.desiredRecycledMaterial  );
    evaluated_dataMatrix (totalElements+1,personID  )=objectiveVal;
    
    GenData.(hexIdentifier).('binaryMember')=binaryMember;
    GenData.(hexIdentifier).('EF')=extractedEFValues;
    GenData.(hexIdentifier).('S11MaxMin')=S11MaxMin;
    GenData.(hexIdentifier).('S22MaxMin')=S22MaxMin;
    GenData.(hexIdentifier).('S12MaxMin')=S12MaxMin;
    GenData.(hexIdentifier).('objectiveVal')=objectiveVal;
    GenData.(hexIdentifier).('RECYCLE')=recycledMaterialEstimate;
    GenData.(hexIdentifier).('TotalParameters')=totalElements;
    
    
    hexID=hexIdentifier(5:end);
    disp('***********************************************************************************')
    disp(hexID)
    disp('***********************************************************************************')
    
    
    
    
end
pause(0.5);
close(f)
GenData.('General').('REF')=refEFvalues;
GenData.('General').('ModelProps')=ModelProperties;

cd(simulationFolder)
delete *.com
delete *.msg
delete *.txt
delete *.odb
delete *.sta
delete *.sim
delete *.prt
delete *.log
delete *.inp
delete *.dat
genDataSaveName="genData_full_"+num2str(genId)+".mat";
save( genDataSaveName,'GenData');
cd(baseDirectory)



fprintf('\n*****\tGENERATION #%d simulation complete\t***********',genId);


end