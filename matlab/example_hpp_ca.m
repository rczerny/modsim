function retstr = example_hpp_ca(instruct)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Short description of example:
%
% TOPIC:         "Cellular Automata"
% CHAPTER:       "HPP Lattice-Gas Cellular Automata"
% EXAMPLE:       example_hpp_ca
% ID:            hpp_ca
% KEYWORDS:      "hpp, cellular automata, lattice-gas, ca"
% DESCRIPTION:   "This example is a HPP Lattice-gas cellular automaton.
%                 It simulates the distribution of gas over time."
% AUTHORS:       "Czerny, Ren?; Mayer, Michael; Rubas, Daniel"
% LAST UPDATE:   "19 February, 2014"
% BY:            "Czerny, Ren?"
%
% Part of the MMT E-Learning Platform by ASC-MMS and DWH.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% EXTRACTION OF INPUT VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input values from the web-interface must be extracted from a text string.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extraction of input variables from a text string.
DURATION=str2num(instruct.duration);
HEIGHT=str2num(instruct.height);
WIDTH=str2num(instruct.width);
SCENARIO=str2num(instruct.scenario);

%================================= END OF SPECIFIC CODE - CUT HERE ========
%% CONSTANT VARIABLES AND PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constant variables and parameters are defined in this section.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% duration in ticks
if ~exist('DURATION', 'var')
    DURATION = 200;
end
% height and width of the field
if ~exist('HEIGHT', 'var')
    HEIGHT = 50;
end
if ~exist('WIDTH', 'var')
    WIDTH = 50;
end
if ~exist('SCENARIO', 'var')
    SCENARIO = 0;
end
%FILLRATIO = 0.5;
% initial random filling
fields = randi(16,HEIGHT,WIDTH)-1;
kernel1 = [ones(HEIGHT, floor(WIDTH/2)), zeros(HEIGHT, ceil(WIDTH/2))];
kernel2 = [ones(floor(HEIGHT/2), WIDTH); zeros(ceil(HEIGHT/2), WIDTH)];
kernel3 = [ones(floor(HEIGHT/2), ceil(WIDTH/2)), zeros(floor(HEIGHT/2), ceil(WIDTH/2)); 
    zeros(floor(HEIGHT/2), ceil(WIDTH/2)),ones(floor(HEIGHT/2), ceil(WIDTH/2))];
if (SCENARIO == 1)
    fields = fields .* kernel1;
elseif (SCENARIO == 2)
    fields = fields .* kernel2;
elseif (SCENARIO == 3)
    fields = fields .* kernel3;
end

%% CALCULATIONS, FUNCTION CALLS AND MAIN PROGRAM %%%%%%%%%%%%%%%%%%%%%%%%%%
% All general calculations and operations come here.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pre-allocation of memory for efficient use
animation = cell(HEIGHT, WIDTH, DURATION);
% actual calculations
i = 0;
while (i < DURATION)
    i = i+1;
    % collision
    for row = 1:HEIGHT
        for column = 1:WIDTH
            collisionField = fields(row, column);
            if collisionField == 5
                EWcollisions = EWcollisions + 1;
                fields(row, column) = 10;
            elseif collisionField == 10;
                NScollisions = NScollisions + 1;
                fields(row, column) = 5;
            end
        end
    end
    
    fieldsNew = zeros(HEIGHT, WIDTH);
    % propagation
    for row = 1:HEIGHT
        for column = 1:WIDTH
            % handle north particle
            if any(fields(row, column) == [8,9,10,11,12,13,14,15])
                if row <= 1
                    fieldsNew(row, column) = fieldsNew(row, column) + 2;
                    Nbounce = Nbounce + 1;
                else
                    fieldsNew(row-1, column) = fieldsNew(row-1, column) + 8;
                end
            end
            % handle south particle
            if any(fields(row, column) == [2,3,6,7,10,11,14,15])
                if row >= HEIGHT
                    fieldsNew(row, column) = fieldsNew(row, column) + 8;
                    Sbounce = Sbounce + 1;
                else
                    fieldsNew(row+1, column) = fieldsNew(row+1, column) + 2;
                end
            end
            % handle east particle
            if any(fields(row, column) == [4,5,6,7,12,13,14,15])
                if column >= WIDTH
                    fieldsNew(row, column) = fieldsNew(row, column) + 1;
                    Ebounce = Ebounce + 1;
                else
                    fieldsNew(row, column+1) = fieldsNew(row, column+1) + 4;
                end
            end
            % handle west particle
            if any(fields(row, column) == [1,3,5,7,9,11,13,15])
                if column <= 1
                    fieldsNew(row, column) = fieldsNew(row, column) + 4;
                    Wbounce = Wbounce + 1;
                else
                    fieldsNew(row, column-1) = fieldsNew(row, column-1) + 1;
                end
            end
        end
    end
    fields = fieldsNew;
    animation{i} = fields;
end

%% GRAPHICAL OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphical output is generated here.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pic = figure('visible','off');
% disables graphical output on the remote system. Switch 'on' at home.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create color map, so we don't have to recalculate the grey values over
% and over again
cmRow = [1;0.75;0.75;0.5;0.75;0.5;0.5;0.25;0.75;0.5;0.5;0.25;0.5;0.25;0.25;0];
specialGray = [cmRow, cmRow, cmRow];
colormap(specialGray);
image(animation{1}+1);
drawnow
%================================= BEGIN OF SPECIFIC CODE - CUT HERE ======
r=adamInitialize();
r=adamRenderAnimatedCreate(r,instruct,Pic,0.2,'HPP cellular automaton');
%================================= END OF SPECIFIC CODE - CUT HERE ========
for i = 1:length(animation)
   image(animation{i}+1);
   drawnow
%================================= BEGIN OF SPECIFIC CODE - CUT HERE ======
   r=adamRenderAnimatedAppend(r,instruct,Pic,0.2);
%================================= END OF SPECIFIC CODE - CUT HERE ======
end
%================================= BEGIN OF SPECIFIC CODE - CUT HERE ======
%% END OF EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
