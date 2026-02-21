function newGen= getNewGeneration (dataMatrix_sorted,optInitVars, optRec ,ModelProperties)

totalParameters=optInitVars.totalParameters;
populationCutOff=optInitVars.populationCutoff;
defaultCrossoverPopulation=0.7;
if length(optRec.objectiveHistory)>20 && mod(length(optRec.objectiveHistory),5)==0
    relativeChange=    100*abs(optRec.objectiveHistory (end-15)-optRec.objectiveHistory (end))/optRec.objectiveHistory (end-15);
    
    if ( relativeChange < 5 )
        disp('objective flattened in last 15 generations, increasing immigration for this generation')
        defaultCrossoverPopulation=0.4;
    end
end




populationCutOff_crossover=floor(populationCutOff*defaultCrossoverPopulation);
populationCutOff_immigration=populationCutOff-populationCutOff_crossover;






mu=0.001;
selectionVector=populationCutOff+1:optInitVars.populationSize;
possiblities = nchoosek(selectionVector,2);
randomizedPermutation = randperm(length(possiblities),populationCutOff);
pairsOfParents=possiblities(randomizedPermutation,:);
newGen=zeros(totalParameters+1,populationCutOff);

f = waitbar(0, 'Starting');


for individual=1:populationCutOff_crossover
    waitbar(individual/populationCutOff, f, sprintf('Populating crossover generation %d %% complete ', floor(individual*100/populationCutOff) ) );
    flagOfExistingMember=1;
    flagOfViolation_MaxRecycledMaterialConstraint=1;
    flagOfViolation_MinRecycledMaterialConstraint=1;
    uniqueChildGenerationAttempt=0;
    while flagOfExistingMember || flagOfViolation_MaxRecycledMaterialConstraint || flagOfViolation_MinRecycledMaterialConstraint
        generatedGeneration=uint8(newGen(1:totalParameters,:));
        
        if uniqueChildGenerationAttempt>1000
            
            possiblities = nchoosek(selectionVector,2);
            randomizedPermutation = randperm(length(possiblities),populationCutOff);
            pairsOfParents=possiblities(randomizedPermutation,:);
            uniqueChildGenerationAttempt=0;
        end
        
        parent1=dataMatrix_sorted(1:totalParameters,pairsOfParents(individual,1));
        parent2=dataMatrix_sorted(1:totalParameters,pairsOfParents(individual,2));
        [~,generatedChild]=MyCrossover(parent1',parent2');
        uniqueChildGenerationAttempt=uniqueChildGenerationAttempt+1;
        generatedChild=Mutate(generatedChild,0.5*uniqueChildGenerationAttempt*mu);
        
        
        
        
        [~,previousHistoryIndex] = ismember(generatedChild,optRec.populationLog','rows');
        [~,currentGeneratedIndex] =ismember(generatedChild,generatedGeneration','rows');
        flagOfExistingMember=previousHistoryIndex||currentGeneratedIndex;
        
        if ~flagOfExistingMember
            recycledMaterialEstimate= getRecycledMaterialEstimate  (generatedChild , ModelProperties   );
            flagOfViolation_MaxRecycledMaterialConstraint=recycledMaterialEstimate>optInitVars.maxRecycleMaterial;
            flagOfViolation_MinRecycledMaterialConstraint=recycledMaterialEstimate<optInitVars.minRecycleMaterial;
            
            if ~flagOfViolation_MaxRecycledMaterialConstraint && ~flagOfViolation_MinRecycledMaterialConstraint && sum(generatedChild)>1
                newGen(1:totalParameters,individual)=generatedChild;
                break
            end
        else
            continue
        end
    end
    
end




for individual=populationCutOff_crossover+1:populationCutOff
    waitbar(individual/populationCutOff, f, sprintf('Populating immigrant generation %d %% complete ', floor(individual*100/populationCutOff) ) );
    flagOfExistingMember=1;
    flagOfViolation_MaxRecycledMaterialConstraint=1;
    flagOfViolation_MinRecycledMaterialConstraint=1;
    while flagOfExistingMember || flagOfViolation_MaxRecycledMaterialConstraint || flagOfViolation_MinRecycledMaterialConstraint
        generatedGeneration=uint8(newGen(1:totalParameters,:));
        
        if rand<0.5
            generatedChild=uint8(randi(2, [1 totalParameters]) - 1);
        else
            generatedChild=zeros(1,totalParameters);
            generatedChild=Mutate(generatedChild,rand*0.15);
        end
        
        
        
        [~,previousHistoryIndex] = ismember(generatedChild,optRec.populationLog','rows');
        [~,currentGeneratedIndex] =ismember(generatedChild,generatedGeneration','rows');
        flagOfExistingMember=previousHistoryIndex||currentGeneratedIndex;
        
        if ~flagOfExistingMember
            recycledMaterialEstimate= getRecycledMaterialEstimate  (generatedChild , ModelProperties   );
            flagOfViolation_MaxRecycledMaterialConstraint=recycledMaterialEstimate> (optInitVars.maxRecycleMaterial+0.03);
            flagOfViolation_MinRecycledMaterialConstraint=recycledMaterialEstimate< (optInitVars.minRecycleMaterial-0.03);
            
            
            if ~flagOfViolation_MaxRecycledMaterialConstraint && ~flagOfViolation_MinRecycledMaterialConstraint && sum(generatedChild)>1
                newGen(1:totalParameters,individual)=generatedChild;
                break
            end
            
        else
            continue
        end
    end
end

newGen=unique(newGen','rows');
newGen=newGen';

close(f)











end