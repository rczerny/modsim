% width and height of the field
WIDTH = 100;
HEIGHT = 100;
% initial random filling
fields = randi(16,HEIGHT,WIDTH)-1;
% create color map, so we don't have to recalculate the grey values over
% and over again
cmRow = [0;0.25;0.25;0.5;0.25;0.5;0.5;0.75;0.25;0.5;0.5;0.75;0.5;0.75;0.75;1];
specialGray = [cmRow, cmRow, cmRow];
colormap(specialGray);
image(fields)

% collision
for row = 1:HEIGHT
    for column = 1:WIDTH
        if field(row, column) == 5
            field(row, column) = 10;
        elseif field(row, column) == 10;
            field(row, column) = 5;
        end
    end
end

fieldsNew = fields;
% propagation
for row = 1:HEIGHT
    for column = 1:WIDTH
        if % blabbediblub, hier fehlt noch etwas :-)
        end
    end
end
