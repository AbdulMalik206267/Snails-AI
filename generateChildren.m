function children = generateChildren( board, turn )
   [ snail_x, snail_y ] = find( board == turn );
   children = zeros(8, 8, 1);
   
   %child generated by up movement
   temp_x = snail_x - 1;
   [ islegal, movement ] = isLegal(board, temp_x, snail_y, turn);
   
   tempChildren = children;
   if islegal
       tempChildren(:, :, 1) = board(:, :);
       if turn == 11
        tempChildren(snail_x, snail_y, 1) = 1;
       else
        tempChildren(snail_x, snail_y, 1) = 2;
       end
       tempChildren(temp_x, snail_y, 1) = turn;
       children(:, :, 1) = tempChildren;
   end
   
   %child generated due to right move
   temp_y = snail_y + 1;
   [ islegal, movement ] = isLegal(board, snail_x, temp_y, turn);
   
   if islegal
       if tempChildren(snail_x, snail_y, 1) ~= 0
           children = zeros(8, 8, 2);
           children(:, :, 1) = tempChildren(:, :, 1);
       end
       
       [ temp temp length ] = size(children);
       children( :, :, length ) = board(:, :);
       
        if turn == 11
            children(snail_x, snail_y, length) = 1;
        else
            children(snail_x, snail_y, length) = 2;
       end
       children(snail_x, temp_y, length) = turn;
       tempChildren = children;
   end
   
   %child generated due to down movement
   temp_x  = snail_x + 1;
   [ islegal, movement ] = isLegal(board, temp_x, snail_y, turn);
   
   if islegal
       [ temp temp length ] = size(tempChildren);
       if tempChildren(snail_x, snail_y, 1) ~= 0
           length = length + 1;
           
           children = zeros(8, 8, length);
           for child=1:length - 1
               children(:, :, child) = tempChildren(:, :, child);
           end
       end
       
       children(:, :, length) = board(:, :);
       if turn == 11
           children(snail_x, snail_y, length) = 1;
       else
           children(snail_x, snail_y, length) = 2;
       end
       
       children(temp_x, snail_y, length) = turn;
       tempChildren = children;
   end
  
   %child generated due to left movement
   temp_y  = snail_y - 1;
   [ islegal, movement ] = isLegal(board, snail_x, temp_y, turn);
   
   if islegal
       [ temp temp length ] = size(tempChildren);
       if tempChildren(snail_x, snail_y, 1) ~= 0
           length = length + 1;
           
           children = zeros(8, 8, length);
           for child=1:length - 1
               children(:, :, child) = tempChildren(:, :, child);
           end
       end
       
       children(:, :, length) = board(:, :);
       if turn == 11
           children(snail_x, snail_y, length) = 1;
       else
           children(snail_x, snail_y, length) = 2;
       end
       
       children(snail_x, temp_y, length) = turn;
   end
end
 