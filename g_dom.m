% G_DOM.M      (Goldberg Dominance)
%
% This function implements the Goldberf Dominance.
%
% Syntax:  ObjVal = objfun_ff(MObjV,myswitch)
%
% Input parameters:
%    MObjV     - Matrix containing the result of multi objective function
%                for a given Chrom                      

%                if MObjV == [], then special values will be returned
%    myswitch    - if MObjV == [] and
%                myswitch == 1 (or []) return boundaries
%                myswitch == 2 return title
%                myswitch == 3 return value of global minimum
%
% Output parameters:
%    ObjVal    - Matrix containing the objective values of the
%                individuals in the current population.
%                if called with Chrom == [], then ObjVal contains
%                switch == 1, matrix with the boundaries of the function
%                switch == 2, text for the title of the graphic output
%                switch == 3, value of global minimum
%                

% Author:     Jesus Batta
% History:    08.11.16     file created
%             
function ObjVal = g_dom(MObjV,myswitch)

% Dimension of objective function
   Dim = 2;
   
% Compute population parameters
   [Nind,Nvar] = size(MObjV);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if myswitch == 2
         ObjVal = ['FONSECA FLEMING function -' int2str(Dim)];
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
       
       tic=0;
       NT = [MObjV,[1:Nind]'];
       LNT = size(NT);
       LNT = LNT(1);
       ObjVal = ones(Nind,1)*NaN;
       
       while LNT>0
            
            NTN=[];
            temp = zeros(LNT,1);
            for i = 1:LNT
            for j = 1:LNT
                if i ~= j
                if (NT(i,1)>NT(j,1))&&(NT(i,2)>=NT(j,2))||(NT(i,2)>NT(j,2))&&(NT(i,1)>=NT(j,1))
                    temp(i,1)=temp(i,1)+1;
                end
                end
            end
            if temp(i,1)==0
                ObjVal(NT(i,3),1)=tic;
            else
                NTN=[NTN;NT(i,:)];
            end
            end
            tic = tic +1;
            NT = NTN;
            LNT = size(NT);
            LNT = LNT(1);
       end
       
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function
