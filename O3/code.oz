declare QuadraticEquation Sum RightFold Sum2 Length2 Quadratic LazyNumberGenerator in

%--------------------------------------------------------------------------------------------------

% 1
proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
    % Check for no real solutions
    if B*B-4.0*A*C<0.0 then 
        RealSol = false
    % Bind solutions to X1 and X2
    else 
        X1 = (0.0-B-{Sqrt B*B-4.0*A*C})/(2.0*A)
        X2 = (0.0-B+{Sqrt B*B-4.0*A*C})/(2.0*A)
        RealSol = true
    end
end

% Test on equation with solutions
local X1 X2 RealSol in 
    {QuadraticEquation 2.0 1.0 ~1.0 RealSol X1 X2}
    {Show RealSol}
    {Show X1}
    {Show X2}
    % We see that X1 and X2 are bound to the roots of the functions
end

% Test on equation with no solutions
local _ _ RealSol in 
    {QuadraticEquation 2.0 1.0 2.0 RealSol _ _}
    {Show RealSol}
    % If we were to print X1 and X2 here, the program would halt, as they are unbound 
end

%--------------------------------------------------------------------------------------------------

% 2
fun {Sum List}
    % Add the numbers of the list recursively
    case List of Head|Tail then 
        Head + {Sum Tail}
    else 
        0 
    end 
end 
% See that this adds up to 10
{Show {Sum [1 2 3 4]}}

%--------------------------------------------------------------------------------------------------

% 3
fun {RightFold List Op U}
    % Pattern match to get head 
    case List of Head|Tail then 
        % Return the result of doing OP on Head 
        % and the result from the Tail of the list
        { Op Head {RightFold Tail Op U} }
    else 
        % Base case 
        U
    end 
end

% Define Sum2=Sum using RightFold
fun {Sum2 List}
    {RightFold List fun {$ X Y} X+Y end 0}
end

% Test that this gives 10
{Show {Sum2 [1 2 3 4]}}

% Define Length2=Length using RightFold
fun {Length2 List}
    {RightFold List fun {$ _ Y} 1+Y end 0}
end

% Test that this gives 4
{Show {Length2 [1 2 3 4]}}

%--------------------------------------------------------------------------------------------------

% 4
fun {Quadratic A B C}
    % Return a function that takes a single argument,
    % using the environment (A, B, C) to calculate 
    % the quadratric function value 
    fun {$ X }
        A * X * X + B * X + C 
    end
end

{Show {{Quadratic 3 2 1} 2}}

%--------------------------------------------------------------------------------------------------
 
% 5
fun {LazyNumberGenerator N} F in 
    % F is a function that takes no arguments 
    % and returns the value of this function with N=N+1
    F = fun {$} {LazyNumberGenerator N+1} end
    % Return a tuple of the current "count" and 
    % the function F that generates the next count
    laz(1:N 2:F) 
end

% Test on these 
{Show {LazyNumberGenerator 0}.1}
{Show {{LazyNumberGenerator 0}.2}.1}
{Show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1}
