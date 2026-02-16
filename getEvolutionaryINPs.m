function  getEvolutionaryINPs (dirPaths,optRec,ModelProperties)
allGenerations=fieldnames(optRec.performanceLog);
evolutionFolder=fullfile(dirPaths.simulationWorkspaceDirectory,['GEN_' int2str(length(allGenerations)-1)],'evolution');

mkdir(evolutionFolder);

for i=1:length(allGenerations)

    performanceMatrix=optRec.performanceLog.([allGenerations{i}]);

    binaryMember=performanceMatrix(1:end-1,end);
    bestINPfileName='RCYCL_'+string(ModelProperties.fileName)+'_GEN_'+string(i-1)+'_best';
    bestINPfileName=bestINPfileName+'.inp';
    INPfullPath=fullfile(evolutionFolder,bestINPfileName );

    writeINP (INPfullPath,...
        binaryMember,...
        ModelProperties     );



end
end

