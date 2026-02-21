function INPfile= writeINP (INPfullPath,...
    binaryMember,...
    ModelProperties     )


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

for plyID=1: length(Widths)
    RegionName=PliesToSplit(plyID,:);
    ClustersInPly=ModelProperties.PlyData.([RegionName]).ClustersRecycled;
    BinaryMap=binaryPart{plyID};
    activeCluster=getActiveClusters(ClustersInPly,BinaryMap);

    if (~isempty(activeCluster))
        stringForAddition=stringForAddition+string(generateSectionAdditionText(activeCluster,ModelProperties,RegionName));
    end

end

FullINPString=ModelProperties.preString+stringForAddition+ModelProperties.postString;

fid = fopen(INPfullPath,'w');
fprintf(fid,FullINPString{:});
fclose(fid);



end