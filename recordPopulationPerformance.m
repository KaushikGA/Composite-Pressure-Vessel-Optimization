function optRec=recordPopulationPerformance(dataMatrix, optRec,fullGenData,genId)


[dmRows,dmCols]=size(dataMatrix);
currentPopulation=dataMatrix(1:dmRows-1,:);


quarterOfPopulation=floor(dmCols*0.25);

populationLog=optRec.populationLog;


populationLog=[populationLog currentPopulation];

populationLog=unique(populationLog','rows');
populationLog=populationLog';



performanceLogIdentifierString='gen_' +string(genId) +'_perf';
optRec.performanceLog.(performanceLogIdentifierString)=dataMatrix;
optRec.populationLog=populationLog;

optRec.currentBestObj=dataMatrix(end,end); %Record best objective value
optRec.currentBestMember=dataMatrix(:,end-1); %Record best parameter config


optRec.objectiveHistory=[optRec.objectiveHistory optRec.currentBestObj];
topPerformanceValues=dataMatrix(end,end-quarterOfPopulation:end);
optRec.meanTopPerformances=[optRec.meanTopPerformances  mean(topPerformanceValues)];

optRec.performanceLogFull.(performanceLogIdentifierString)=fullGenData;

end