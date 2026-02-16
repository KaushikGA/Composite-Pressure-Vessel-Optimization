function initialPopulation=initilializePopulation (populationSize , ModelProperties ,optRec ,optInitVars )

totalParameters=length(ModelProperties.allClusters);
dataMatrix=zeros(totalParameters+1,populationSize);
for p=1:populationSize
    flagOfExistingMember=1;
    flagOfViolation_MaxRecycledMaterialConstraint=1;
    flagOfViolation_MinRecycledMaterialConstraint=1;
    while flagOfExistingMember || flagOfViolation_MaxRecycledMaterialConstraint || flagOfViolation_MinRecycledMaterialConstraint
        generatedGeneration=uint8(dataMatrix(1:totalParameters,:));
        
        if rand<0.5
            generatedChild=uint8(randi(2, [1 totalParameters]) - 1);
        else
            generatedChild=zeros(1,totalParameters);
            generatedChild=Mutate(generatedChild,rand*0.15);
        end
        
        
        generatedChild=Mutate(generatedChild,rand*0.15);
        if ~isempty(optRec.populationLog)
            [~,previousHistoryIndex] = ismember(generatedChild,optRec.populationLog','rows');
        else
            previousHistoryIndex=false;
        end
        
        [~,currentGeneratedIndex] =ismember(generatedChild,generatedGeneration','rows');
        flagOfExistingMember=previousHistoryIndex || currentGeneratedIndex;
        if ~flagOfExistingMember
            recycledMaterialEstimate= getRecycledMaterialEstimate  (generatedChild , ModelProperties   );
            flagOfViolation_MaxRecycledMaterialConstraint=recycledMaterialEstimate>optInitVars.maxRecycleMaterial;
            flagOfViolation_MinRecycledMaterialConstraint=recycledMaterialEstimate<optInitVars.minRecycleMaterial;
            
        else
            continue
        end
        
    end
    dataMatrix(1:totalParameters,p)=generatedChild;
end
fprintf('\n*****\tRandomized Initial population Matrix ready\t***********\n');


initialPopulation=dataMatrix;




end






