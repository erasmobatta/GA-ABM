function ObjVal=abmfun_lf(Chrom,fileID,myswitch)
 % Dimension of objective function
   Dim = 3;
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if myswitch == 2
         ObjVal = ['ABM function 1-' int2str(Dim)];
      % return value of global minimum
      elseif myswitch == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = 100*[-5.12; 5.12];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   
   % if Dim variables, compute values of function
   elseif Nvar == Dim
        ObjVal =ones(Nind,1);
        for i=1:Nind
            BMet=Chrom(i,1);
            ThV=Chrom(i,2);
            cone=Chrom(i,3);
            commandStr = 'python /home/erasmo/Escritorio/agent_python/test_lf.py';
            commandStr =[commandStr,' ',num2str(BMet),' ',num2str(ThV),' ',num2str(cone)];
            [status, aa] = system(commandStr);
            a = textscan(aa,'%d %d','delimiter','\n');
            if a{1}>0
                ObjVal(i)=a{2}/a{1};
            end
            fprintf(fileID,'%f , %f , %f , %d , %d \n',BMet, ThV, cone, a{1}, a{2});
        end
    
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end
end