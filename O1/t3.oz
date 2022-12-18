% a
declare Y = 300 Z = 30 X
X = Y * Z

% b 
declare X Y 
X = "This is a string"
thread {System.showInfo Y} end
Y = X

% This is because of the data flow model in Oz, where as long a variable is variable is declared,
% it not being defined will not cause an error, but rather halt execution of the thread in question until
% the variable has been given a value  

% This makes programming with concurrency easier compared to using signals

% It means that Y should take on the value represented by the symbol X