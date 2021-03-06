% initilizing game setup
rows = 8; cols = 8;
board = initializeBoard(rows, cols);
board(1, 8) = 22;
board(8, 1) = 11;
grid = boardToGrid( board );
imshow( grid );

turn = 11;
agentTurn = 22;
depth = 2;

% initially agent score and opponent score is 1
scoreOpp = 1;
scoreAgent = 1;
% while game continuos 
while 1
   % if it is not agent
   if( turn ~= agentTurn )
      [x, y] = ginput(1);
      temp = y;
      y = floor(x/100)+1;
      x = floor(temp/100)+1;
      
      [xx, yy] = find (board == 11);
      [ islegal, movement ] = isLegal(board, x, y, 11); % if its a legal move
      if ( islegal == false )
          msgbox('Invalid Input', 'Error','error')    
      else
          board(xx, yy) = 1;
          [ x, y ] = slideSnail( board, x, y, turn, movement );% slide snail if possible
          if board(x, y) ~= 1
              scoreOpp = scoreOpp + 1;
          end
          board(x, y) = 11;
          turn = changeTurn(turn); % change turn
      end
   % if it is agent move
   else
      [ board, value, scoreAgent ] = searchTree( board, turn, agentTurn, depth, scoreAgent, scoreOpp );
      % [ board, scoreAgent ] = findOptimalMove( board, turn, agentTurn, scoreAgent, scoreOpp ); % find optimal move using heuristic
      turn = changeTurn(turn); % chagne turn
   end
   
   grid = boardToGrid(board); % convert board to grid
   imshow(grid); % showing grid
   
   % stop game if no possible move
   score = gameStatus( board, agentTurn ); 
   if score ==  10 || score == -10
       if score == 10
           disp('agent won');
       else
           disp('opponent won');
       end
       break;
   end
end