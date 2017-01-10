commandStr = 'python /home/erasmo/Escritorio/agent_python/test.py 1 1 2';
[status, aa] = system(commandStr);
a = textscan(aa,'%d %d','delimiter','\n');
pop=a{1};
lfraction=a{2}/a{1};