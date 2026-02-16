function recycledMaterialEstiamate= getRecycledMaterialEstimate  (binaryMember , ModelProperties   )


Widths=ModelProperties.Widths;
mappingIndex=cumsum(ModelProperties.Sequences.clustersInPliesToRecycle);
mappingIndex=[0 mappingIndex];
PliesToSplit=    ModelProperties.PliesToSplit;


for i=1: length(mappingIndex)-1
    mappingStartIndex=mappingIndex(i)+1 ;
    mappingEndIndex=mappingIndex(i+1);

    binaryPart{i}=binaryMember(mappingStartIndex:mappingEndIndex  );

end

stringForAddition='';

totalElementsInPly=[];
recycledElementsInPly=[];
for plyID=1: length(Widths)
    RegionName=PliesToSplit(plyID,:);
    ClustersInPly=ModelProperties.PlyData.([RegionName]).ClustersRecycled;
    BinaryMap=binaryPart{plyID};
    recycledElements=getActiveClusters(ClustersInPly,BinaryMap);
    totalElements=ModelProperties.PlyData.([RegionName]).TotalElements;

    totalElementsInPly=[totalElementsInPly totalElements];
    recycledElementsInPly=[recycledElementsInPly length(recycledElements)];
end


totalElementsInAllRecyclablePlies=sum(totalElementsInPly);
recycledElementsInAllRecyclablePlies=sum(recycledElementsInPly);

recycledMaterialEstiamate=recycledElementsInAllRecyclablePlies/totalElementsInAllRecyclablePlies;


end