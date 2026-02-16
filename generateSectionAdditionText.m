function FullFileString=generateSectionAdditionText(activeCluster,ModelProperties,RegionName)
% ** Region: (CompositeLayupRe: Generated From Layup)
% *Elset, elset=CompositeLayupRe

% ** Section: CompositeLayupRe
% *Shell Section, elset=CompositeLayupRe, composite, stack direction=3, layup=CompositeLayupRe
% 1., 3, CFRP_Recycled, 45., CompositeLayupRe

TotalElementsInCluster=length(activeCluster);
foldLimit=10;
elementText='';
for ElementInCluster=1:TotalElementsInCluster
    if mod(ElementInCluster,TotalElementsInCluster)==0 %
        elementText=elementText+string(activeCluster(ElementInCluster))+newline;
    elseif  mod(ElementInCluster,foldLimit)==0
        elementText=elementText+string(activeCluster(ElementInCluster))+newline;
    else
        elementText=elementText+string(activeCluster(ElementInCluster))+',';
    end
end

lineSet1=ModelProperties.PlyData.([RegionName]).TextData.Recycled_LS1;
lineSet2=ModelProperties.PlyData.([RegionName]).TextData.Recycled_LS2;
lineSet3=elementText;
lineSet4=ModelProperties.PlyData.([RegionName]).TextData.Recycled_LS4;
lineSet5=ModelProperties.PlyData.([RegionName]).TextData.Recycled_LS5;
lineSet6=ModelProperties.PlyData.([RegionName]).TextData.Recycled_LS6;


FullFileString=string(lineSet1)+newline+...
    string(lineSet2)+newline+...
    lineSet3+...
    string(lineSet4)+newline+...
    string(lineSet5)+newline+...
    string(lineSet6)+newline;




end