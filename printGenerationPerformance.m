function printGenerationPerformance ( optRec , ModelProperties   )

allGenerationsRecorded=fieldnames(optRec.performanceLog);
mostAdvancedGeneration=allGenerationsRecorded{end};
splitTextAdvGen=split(mostAdvancedGeneration,'_');
mostAdvancedGenID=str2num(splitTextAdvGen{2});
optRec.objectiveHistory=optRec.objectiveHistory(1:mostAdvancedGenID);
optRec.meanTopPerformances=optRec.meanTopPerformances(1:mostAdvancedGenID);
Widths=ModelProperties.Widths;
bestMember=optRec.currentBestMember;

recycledMaterial=getRecycledMaterialEstimate  (bestMember , ModelProperties   );

objectiveValue=optRec.currentBestObj;

fprintf( '\nGEN: %d | Obj: %f | RCYCLE: %f %%\n' ,mostAdvancedGenID,objectiveValue, 100*recycledMaterial  );
end
