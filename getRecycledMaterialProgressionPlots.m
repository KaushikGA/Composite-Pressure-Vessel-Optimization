
function RecycledMaterialProgressionPlots= getRecycledMaterialProgressionPlots( optRec , ModelProperties   )

allGenerationsRecorded=fieldnames(optRec.performanceLog);
mostAdvancedGeneration=allGenerationsRecorded{end};
splitTextAdvGen=split(mostAdvancedGeneration,'_');
mostAdvancedGenID=str2num(splitTextAdvGen{2});
optRec.objectiveHistory=optRec.objectiveHistory(1:mostAdvancedGenID);
optRec.meanTopPerformances=optRec.meanTopPerformances(1:mostAdvancedGenID);
Widths=ModelProperties.Widths;
mappingIndex=cumsum(ModelProperties.Sequences.clustersInPliesToRecycle);
mappingIndex=[0 mappingIndex];
PliesToSplit=    ModelProperties.PliesToSplit;

recycledMaterialContent=struct();

for genID=0:length(allGenerationsRecorded)-1
    genIDStructRecordKey="gen_"+num2str(genID)+"_perf";
    genMaterialRecordStructRecordKey="gen_"+num2str(genID)+"_recycledMaterialRecord";
    performanceOfGeneration=optRec.performanceLog.([genIDStructRecordKey]);
    bestCandidate=performanceOfGeneration(1:end-1,end);
    for i=1: length(mappingIndex)-1
        mappingStartIndex=mappingIndex(i)+1 ;
        mappingEndIndex=mappingIndex(i+1);

        binaryPart{i}=bestCandidate(mappingStartIndex:mappingEndIndex  );

    end
    for plyID=1: length(Widths)
        RegionName=PliesToSplit(plyID,:);
        ClustersInPly=ModelProperties.PlyData.([RegionName]).ClustersRecycled;
        BinaryMap=binaryPart{plyID};
        recycledElements=getActiveClusters(ClustersInPly,BinaryMap);
        totalElements=ModelProperties.PlyData.([RegionName]).TotalElements;
        recycledMaterialContent.(RegionName).(genMaterialRecordStructRecordKey)=length(recycledElements)/totalElements;
    end
end
fig=figure(2);
%fig.WindowState='maximized'
splitPlies=fieldnames(recycledMaterialContent);
RegionNames={};
for particularPly=1:length(splitPlies)
    legendString=[ splitPlies{particularPly} ', ' char(num2str(ModelProperties.PlyTable{splitPlies{particularPly},"Ply Angle"})) ' DEG'];
    RegionNames{particularPly}=legendString;
    recycleMaterialRecordForPly=recycledMaterialContent.(splitPlies{particularPly});
    recycleMaterialVectorRecordForPly=[];
    xAxis=[];
    for i=1:length(fieldnames(recycleMaterialRecordForPly))
        genMaterialRecordStructRecordKey="gen_"+num2str(i-1)+"_recycledMaterialRecord";
        recycleMaterialVectorRecordForPly=[recycleMaterialVectorRecordForPly recycleMaterialRecordForPly.(genMaterialRecordStructRecordKey)*100];
        xAxis=[xAxis i-1];
    end
    plot(xAxis,recycleMaterialVectorRecordForPly ,'LineWidth',2);
    hold on
end
xlabel('Generation','FontSize',20,'FontWeight','bold')
ylabel('Recycled material percentage','FontSize',20,'FontWeight','bold')
t=title('Progression of recycled material of the best member');
t.FontSize = 20;
legend(RegionNames,'Interpreter', 'none','Location','best','FontSize',16)
hold off
RecycledMaterialProgressionPlots=recycledMaterialContent;
end
