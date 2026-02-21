function extractValues=getReferenceSolution ( ModelProperties, dataMatrix , genId ,...
    dirPaths)

baseDirectory=cd;
%--------------------------------------------------------------------------
%create INPs
[totalRows,totalColmns]=size(dataMatrix);
populationSize=totalColmns;
totalElements=totalRows-1;


simulationFolder=fullfile(dirPaths.initialRunDirectory,['GEN_' int2str(genId)]);
mkdir(simulationFolder);


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
    system(['abaqus job=' INPfileName ' cpus=4' ]);
    fileListLCK=dir('*.lck');
    pause(0.1)
end
fileListLCK=dir('*.lck');
while isempty(fileListLCK)
    fileListLCK=dir('*.lck');
    pause(1)
end
while ~isempty(fileListLCK)
    waitbar(1, f, sprintf(' Currently running: %d ',length(fileListLCK) ) );
    pause(1)
    fileListLCK=dir('*.lck');
end
close(f)
cd(baseDirectory)
pause(0.5);
f = waitbar(0, 'Reading results');
pause(0.5);
%--------------------------------------------------------------------------
%read data from .dat and %fill evaluated_dataMatrix
%--------------------------------------------------------------------------


for personID=1:populationSize
    waitbar(personID/populationSize, f, sprintf('Reading results : %d % complete ', floor(personID*100/populationSize) ) );
    FileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(genId)+'_ID'+string(personID);
    DATfileName=FileName+'.dat';
    DATfilefullPath=fullfile(simulationFolder,DATfileName );
    
    [extractValues ,S11MaxMin ,S22MaxMin ,S12MaxMin,MaxStressData,MinStressData]=extract_5EigenFrequencies_frequencyAnalysis(DATfilefullPath);
    
    getObjectiveVal (extractValues,extractValues ,...
        S11MaxMin ,S22MaxMin ,S12MaxMin ,MaxStressData,MinStressData,...
        1,1  )
    
    
    
end
pause(0.5);
close(f)

cd(simulationFolder)
delete *.com
delete *.msg
delete *.txt
delete *.odb
delete *.sta
delete *.sim
delete *.prt
delete *.log

cd(baseDirectory)



fprintf('\n*****\tReference simulation complete\t***********');




end