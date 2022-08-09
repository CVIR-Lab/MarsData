function  m = bisection(f, low, high, tol)
%disp('Bisection Method'); 

% Evaluate both ends of the interval
y1 = feval(f, low);
y2 = feval(f, high);
i = 0; 

% Display error and finish if signs are not different
while y1 * y2 > 0
   %disp('Have not found a change in sign. Will not continue...');
   m = 'Error'
   %y1 = feval(f, low);
   high = high*2;
   y2 = feval(f, high);
end 

% Work with the limits modifying them until you find
% a function close enough to zero.
%disp('Iter    low        high          x0');
while (abs(high - low) >= tol)
    i = i + 1;
    % Find a new value to be tested as a root
    m = (high + low)/2;
    y3 = feval(f, m);
    if y3 == 0
        fprintf('Root at x = %f \n\n', m);
        return
    end
    %fprintf('%2i \t %f \t %f \t %f \n', i-1, low, high, m);   

    % Update the limits
    if y1 * y3 > 0
        low = m;
        y1 = y3;
    else
        high = m;
    end
end 

% Show the last approximation considering the tolerance
% w = feval(f, m);
%fprintf('\n x = %f produces f(x) = %f \n %i iterations\n', m, y3, i-1);
%fprintf(' Approximation with tolerance = %f \n', tol); 