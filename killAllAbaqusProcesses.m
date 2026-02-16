function killAllAbaqusProcesses (baseDirectory)
filePathFoRunningTasks=fullfile(baseDirectory,'tlist.txt' );
deleteCommandString="del "+filePathFoRunningTasks;
system(deleteCommandString);
taskListCommandString="tasklist.exe > "+filePathFoRunningTasks;
system(taskListCommandString);
pause(1)
fileContent = fileread(filePathFoRunningTasks);
stringNewlineSplit = splitlines(fileContent);


indexNode = find(contains(stringNewlineSplit,'eliT'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  eliT \n')
end


indexNode = find(contains(stringNewlineSplit,'SMApython'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  SMApython \n')
end

indexNode = find(contains(stringNewlineSplit,'standard.exe'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  standard.exe \n')
end


indexNode = find(contains(stringNewlineSplit,'pre.exe'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  pre.exe \n')
end

indexNode = find(contains(stringNewlineSplit,'SMA'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  SMA \n')
end

indexNode = find(contains(stringNewlineSplit,'ABQ'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  ABQ \n')
end

indexNode = find(contains(stringNewlineSplit,'python.exe'));
if ~isempty(indexNode)
    processesWithName=stringNewlineSplit(indexNode);
    
    for i=1:length(processesWithName)
        taskName=processesWithName{i};
        taskCells=split(taskName);
        processName=taskCells{1};
        processID=taskCells{2};
        taskkillCommand= "taskkill /PID "+processID+" /F";
        fprintf('terminating %s ',processName)
        system(taskkillCommand);
        
    end
else
    
    fprintf('Nothing to terminate for  python.exe \n')
end

system(deleteCommandString);



end