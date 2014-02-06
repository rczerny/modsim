% width and height of the field
WIDTH = 100;
HEIGHT = 100;
FILLRATIO = 0.5;
% initial random filling
fields = randi(16,HEIGHT,WIDTH)-1;
kernel1 = [ones(HEIGHT, WIDTH/2), zeros(HEIGHT, WIDTH/2)];
kernel2 = [ones(HEIGHT/2, WIDTH); zeros(HEIGHT/2, WIDTH)];
kernel3 = [ones(HEIGHT/2, WIDTH/2), zeros(HEIGHT/2, WIDTH/2); zeros(HEIGHT/2, WIDTH/2),ones(HEIGHT/2, WIDTH/2)];
fields = fields .* kernel3;
% create color map, so we don't have to recalculate the grey values over
% and over again
cmRow = [1;0.75;0.75;0.5;0.75;0.5;0.5;0.25;0.75;0.5;0.5;0.25;0.5;0.25;0.25;0];
specialGray = [cmRow, cmRow, cmRow];
colormap(specialGray);
image(fields+1)
colorbar;
i = 0;
EWcollisions = 0;
NScollisions = 0;
Nbounce = 0;
Ebounce = 0;
Sbounce = 0;
Wbounce = 0;
while (i < 100)
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
    image(fields+1);
    drawnow
end
disp(['NScollisions: ', int2str(NScollisions)])
disp(['EWcollisions: ', int2str(EWcollisions)])
disp(['Nbounce: ', int2str(Nbounce)])
disp(['Sbounce: ', int2str(Sbounce)])
disp(['Wbounce: ', int2str(Wbounce)])
disp(['Ebounce: ', int2str(Ebounce)])
