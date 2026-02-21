function [stressError,effort]= getStressError(actualStress,stressMinLimit,stressMaxLimit)


if actualStress<0
  effort=actualStress/stressMinLimit;
else 
effort=actualStress/stressMaxLimit;
end

effort_shifted=effort-0.49;
stressError=100./( 1+ exp(-1000*effort_shifted)  );

%disp( ['Stress value= ' num2str(actualStress) '   Effort= ' num2str(effort)  '   Sigmoid stressError= ' num2str(stressError) ])
end