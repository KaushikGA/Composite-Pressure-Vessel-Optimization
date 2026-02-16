function objectiveVal= getObjectiveVal (refEFvalues,extractedEFValues ,...
    S11MaxMin ,S22MaxMin ,S12MaxMin ,MaxStressData,MinStressData,...
    recycledMaterialEstimate , desiredRecycledMaterial  )


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
absoluteError=abs(refEFvalues-extractedEFValues);
relAbsError=100*absoluteError./refEFvalues;
eigenPerformanceError=norm(relAbsError);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%--------------------------------------------------------------------------
%--------------------------------------------------------------------------



materialRelativeDifferenceError=max( 100*( desiredRecycledMaterial- recycledMaterialEstimate  )/desiredRecycledMaterial , 0);



%--------------------------------------------------------------------------
%--------------------------------------------------------------------------







%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
S11Max=2320    ;
S22Max=49     ;
S12Max=67     ;

S11Min=-981   ;
S22Min=-160    ;
S12Min=-67    ;


SafetyFactor=2;

S11MaxLimit=S11Max/SafetyFactor  ;
S22MaxLimit=S22Max/SafetyFactor ;
S12MaxLimit=S12Max/SafetyFactor   ;         
S11MinLimit=S11Min/SafetyFactor ;
S22MinLimit=S22Min/SafetyFactor  ;
S12MinLimit=S12Min/SafetyFactor ;




%--------------------------------------------------------------------------
modelS11Max=S11MaxMin(1)  ;
modelS11Min=S11MaxMin(2)  ;
S11maxEffort=modelS11Max/S11Max;
S11minEffort=modelS11Min/S11Min;

posMaxS11= S11MaxMin(3)  ;
posMinS11= S11MaxMin(4)  ;

modelS12Max=S12MaxMin(1)  ;
modelS12Min=S12MaxMin(2)  ;
S12maxEffort=modelS12Max/S12Max;
S12minEffort=modelS12Min/S12Min;

posMaxS12= S12MaxMin(3)  ;
posMinS12= S12MaxMin(4)  ;

modelS22Max=S22MaxMin(1)  ;
modelS22Min=S22MaxMin(2)  ;
S22maxEffort=modelS22Max/S22Max;
S22minEffort=modelS22Min/S22Min;


posMaxS22= S22MaxMin(3)  ;
posMinS22= S22MaxMin(4)  ;

disp('************************FAILURE LIMITS*********************************************')




if modelS11Max<S11MaxLimit
disp(['Failure(STR) S11 max= ' num2str(S11Max) ' ----  Allowed S11 Max (Tensile)    = ' num2str(S11MaxLimit) ' ------> Model S11 Max (Tensile)    = '  num2str(modelS11Max)  ' ------>>  [  OK  ]      max value from loadcase=  '  num2str(posMaxS11)  ' >>> Effort = ' num2str(S11maxEffort) ' <<<<' ]    )
else                                                                                                                                                                            
disp(['Failure(STR) S11 max= ' num2str(S11Max) ' ----  Allowed S11 Max (Tensile)    = ' num2str(S11MaxLimit) ' ------> Model S11 Max (Tensile)    = '  num2str(modelS11Max)  ' ------>> !!!  VIOLATED  !!!   max value from loadcase=  '  num2str(posMaxS11)    ' >>> Effort = ' num2str(S11maxEffort) ' <<<<'  ]    )
end                                                                                                                                                                             
                                                                                                                                                                                
if modelS11Min>S11MinLimit                                                                                                                                                      
disp(['Failure(STR) S11 min= ' num2str(S11Min) ' ----  Allowed S11 Min (Compressive)= ' num2str(S11MinLimit) ' ------> Model S11 Min (Compressive)= '  num2str(modelS11Min)  ' ------>>   [  OK  ]     min value from loadcase=  '  num2str(posMinS11) ' >>> Effort = ' num2str(S11minEffort) ' <<<<' ]       )
else                                                                                                                                                                            
disp(['Failure(STR) S11 min= ' num2str(S11Min) ' ----  Allowed S11 Min (Compressive)= ' num2str(S11MinLimit) ' ------> Model S11 Min (Compressive)= '  num2str(modelS11Min)  ' ------>> !!!  VIOLATED  !!!   min value from loadcase=  '  num2str(posMinS11)  ' >>> Effort = ' num2str(S11minEffort) ' <<<<'   ]    )
end                                                                                                                                                                            
                                                                                                                                                                               
                                                                                                                                                                               
                                                                                                                                                                               
                                                                                                                                                                               
                                                                                                                                                                               
if modelS22Max<S22MaxLimit                                                                                                                                                     
disp(['Failure(STR) S22 max= ' num2str(S22Max) ' ----  Allowed S22 Max (Tensile)    = ' num2str(S22MaxLimit) ' ------> Model S22 Max (Tensile)    = '  num2str(modelS22Max)  ' ------>>   [  OK  ]     max value from loadcase=  '  num2str(posMaxS22) ' >>> Effort = ' num2str(S22maxEffort) ' <<<<'  ]    )
else                                                                                                                                                                            
disp(['Failure(STR) S22 max= ' num2str(S22Max) ' ----  Allowed S22 Max (Tensile)    = ' num2str(S22MaxLimit) ' ------> Model S22 Max (Tensile)    = '  num2str(modelS22Max)  ' ------>>  !!!  VIOLATED  !!!  max value from loadcase=  '  num2str(posMaxS22)    ' >>> Effort = ' num2str(S22maxEffort) ' <<<<'  ]    )
end                                                                                                                                                                             
                                                                                                                                                                                
if modelS22Min>S22MinLimit                                                                                                                                                      
disp(['Failure(STR) S22 min= ' num2str(S22Min) ' ----  Allowed S22 Min (Compressive)= ' num2str(S22MinLimit) ' ------> Model S22 Min (Compressive)= '  num2str(modelS22Min)  ' ------>>   [  OK  ]     min value from loadcase=  '  num2str(posMinS22)   ' >>> Effort = ' num2str(S22minEffort) ' <<<<'   ]  )
else                                                                                                                                                                    
disp(['Failure(STR) S22 min= ' num2str(S22Min) ' ----  Allowed S22 Min (Compressive)= ' num2str(S22MinLimit) ' ------> Model S22 Min (Compressive)= '  num2str(modelS22Min)  ' ------>> !!!  VIOLATED  !!!   min value from loadcase=  '  num2str(posMinS22)   ' >>> Effort = ' num2str(S22minEffort) ' <<<<'   ]    )
end                                                                                                                                                                             
                                                                                                                                                                                
                                                                                                                                                                                
if modelS12Max<S12MaxLimit                                                                                                                                                      
disp(['Failure(STR) S12 max= ' num2str(S12Max) ' ----  Allowed S12 Max (Tensile)    = ' num2str(S12MaxLimit) ' ------> Model S12 Max (Tensile)    = '  num2str(modelS12Max)  ' ------>>   [  OK  ]     max value from loadcase=  '  num2str(posMaxS12) ' >>> Effort = ' num2str(S12maxEffort) ' <<<<'   ]    )
else                                                                                                                                                                                            
disp(['Failure(STR) S12 max= ' num2str(S12Max) ' ----  Allowed S12 Max (Tensile)    = ' num2str(S12MaxLimit) ' ------> Model S12 Max (Tensile)    = '  num2str(modelS12Max)  ' ------>> !!!  VIOLATED  !!!   max value from loadcase=  '  num2str(posMaxS12)   ' >>> Effort = ' num2str(S12maxEffort) ' <<<<'    ]    )
end                                                                                                                                                                                                
                                                                                                                                                                                                   
if modelS12Min>S12MinLimit                                                                                                                                                                         
disp(['Failure(STR) S12 min= ' num2str(S12Min) ' ----  Allowed S12 Min (Compressive)= ' num2str(S12MinLimit) ' ------> Model S12 Min (Compressive)= '  num2str(modelS12Min)  ' ------>>   [  OK  ]     min value from loadcase=  '  num2str(posMinS12) ' >>> Effort = ' num2str(S12minEffort) ' <<<<'  ]       )
else                                                                                                                                                                                          
disp(['Failure(STR) S12 min= ' num2str(S12Min) ' ----  Allowed S12 Min (Compressive)= ' num2str(S12MinLimit) ' ------> Model S12 Min (Compressive)= '  num2str(modelS12Min)  '------>>  !!!  VIOLATED  !!!   min value from loadcase=  '  num2str(posMinS12)  ' >>> Effort = ' num2str(S12minEffort) ' <<<<'   ]    )
end

%--------------------------------------------------------------------------
disp('*********************************************************************')





SafetyFactor=1;

S11MaxLimit=S11Max/SafetyFactor  ;
S22MaxLimit=S22Max/SafetyFactor ;
S12MaxLimit=S12Max/SafetyFactor   ;         
S11MinLimit=S11Min/SafetyFactor ;
S22MinLimit=S22Min/SafetyFactor  ;
S12MinLimit=S12Min/SafetyFactor ;




[s11MaxError,effort]=getStressError(modelS11Max,S11MinLimit,S11MaxLimit)  ;
[s11MinError,effort]=getStressError(modelS11Min,S11MinLimit,S11MaxLimit)  ;
[s22MaxError,effort]=getStressError(modelS22Max,S22MinLimit,S22MaxLimit)  ;
[s22MinError,effort]=getStressError(modelS22Min,S22MinLimit,S22MaxLimit)  ;                                               
[s12MaxError,effort]=getStressError(modelS12Max,S12MinLimit,S12MaxLimit)  ;
[s12MinError,effort]=getStressError(modelS12Min,S12MinLimit,S12MaxLimit)  ;
                                                                 


s11Error= max (  [s11MaxError   s11MinError] )      ;
s12Error= max (  [s12MaxError   s12MinError] )      ;
s22Error= max (  [s22MaxError   s22MinError] )      ;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

multiObjective=[eigenPerformanceError materialRelativeDifferenceError s11Error s12Error s22Error];

objectiveVal=norm(multiObjective);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
disp('************************MEMBER OUTPUT*********************************************')
disp(['eigenPerformanceError=' num2str(eigenPerformanceError)                      ]       )
disp(['materialRelativeDifferenceError=' num2str(materialRelativeDifferenceError)  ]       )
disp(['s11Error= ' num2str(s11Error  )                                             ]       )
disp(['s22Error= ' num2str(s22Error )                                             ]       )
disp(['s12Error= ' num2str(s12Error)                                               ]       )
disp(['objectiveVal= ' num2str(objectiveVal )                                             ]       )
%--------------------------------------------------------------------------
disp('*********************************************************************')







NumLoadCases=size(MaxStressData,1);
effortMatrixMax=[];
SigmoidMatrixMax=[];
for LC=1:NumLoadCases
    
   LCdata= MaxStressData(LC,:);
   
   LCS11=LCdata(1);
   [LCS11error,EffS11]=getStressError(LCS11,S11MinLimit,S11MaxLimit)  ;
   LCS22=LCdata(2);
   [LCS22error,EffS22]=getStressError(LCS22,S22MinLimit,S22MaxLimit)  ;
   LCS12=LCdata(3);
   [LCS12error,EffS12]=getStressError(LCS12,S12MinLimit,S12MaxLimit)  ;
   
   effortVecMax=[EffS11 EffS22 EffS12];
   SigmoidErrorVecMax=[LCS11error  LCS22error LCS12error];
   
   effortMatrixMax(LC,:)=effortVecMax;
   SigmoidMatrixMax(LC,:)=SigmoidErrorVecMax;
   
   LCdata= MinStressData(LC,:);
   
   LCS11=LCdata(1);
   [LCS11error,EffS11]=getStressError(LCS11,S11MinLimit,S11MaxLimit)  ;
   LCS22=LCdata(2);
   [LCS22error,EffS22]=getStressError(LCS22,S22MinLimit,S22MaxLimit)  ;
   LCS12=LCdata(3);
   [LCS12error,EffS12]=getStressError(LCS12,S12MinLimit,S12MaxLimit)  ;
   
   effortVecMin=[EffS11 EffS22 EffS12];
   SigmoidErrorVecMin=[LCS11error  LCS22error LCS12error];
   
   effortMatrixMin(LC,:)=effortVecMin;
   SigmoidMatrixMin(LC,:)=SigmoidErrorVecMin;
   
   
   
   
   
   
   
   disp(['Load case ' num2str(LC) ' effort:     S11        S22       S12 ' ]  )
   
   disp(['   tensile:           ' num2str(effortVecMax)])
   disp(['   compressive:       ' num2str(effortVecMin)])
end

end