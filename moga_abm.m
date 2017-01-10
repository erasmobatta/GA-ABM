
% Author:     J.E.Batta
% History:    06-Dic-2016     file created
 
% parameters

NIND = 100;           % Number of individuals per subpopulations
MAXGEN = 200;        % maximum Number of generations
GGAP = .9;           % Generation gap, how many new individuals are created
NVAR = 3;           % Generation gap, how many new individuals are created
PRECI = 20;          % Precision of binary representation
fileID = fopen('MOGA_ABM.csv','w'); %file to store  data

% Build field descriptor
   FieldD = [rep([PRECI],[1, NVAR]); [1, pi/2, 0; 10, pi, 3];...
              rep([1; 0; 1 ;1], [1, NVAR])];
   
   
% Initialise population
        Chrom = crtrp(NIND,FieldD);
% Reset counters
   	% best in current population
        gen = 0;			% generational counter

% Evaluate initial population
        MObjV = abmfun2(Chrom,fileID);
        ObjV = g_dom(MObjV);
        figure
        plot(MObjV(:,1),MObjV(:,2),'ro'); xlabel('f1(x)'); ylabel('f2(x)');
        text(0.5,0.95,['Gen = ', num2str(gen)],'Units','normalized');
        drawnow;
        figure       


% Generational loop
        while gen < MAXGEN,

    % Assign fitness-value to entire population
            FitnV = ranking(ObjV);

    % Select individuals for breeding
    
            
            SelCh = select('sus', Chrom, FitnV, GGAP);
            

    % Recombine selected individuals (crossover)
    
            SelCh = recombin('xovsp',SelCh,0.9);

    % Perform mutation on offspring
   
    
            SelCh = mut(SelCh,0.005);

    % Evaluate offspring, call objective function
         MObjVSel = abmfun(SelCh,fileID);   
           
         ObjVSel = g_dom(MObjVSel);
         
       

    % Reinsert offspring into current population
            [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);

    % Increment generational counter
            gen = gen+1;

    % Update display and record current best individual
           MObjV=abmfun2(Chrom,fileID);
            plot(MObjV(:,1),MObjV(:,2),'ro'); xlabel('f1(x)'); ylabel('f2(x)');
            text(0.5,0.95,['Gen = ', num2str(gen)],'Units','normalized');
            drawnow;
            
        end 
    

%save('bestGA.mat',Best)
%example = matfile('bestGA.mat');
%C = example.Best;

