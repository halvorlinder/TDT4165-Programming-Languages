% 1
    local A=10 B=20 C=30 in
        {System.show C}
    thread
        {System.show A}
        {Delay 100}
        {System.show A * 10}
    end
    thread
        {System.show B}
        {Delay 100}
        {System.show B * 10}
    end
        {System.show C * 100}
    end
% 30
% 3000
% 10
% 20
% 200
% 100
local A B C in
    thread
        A = 2
        {System.show A}
    end
    thread
        B = A * 10
        {System.show B}
    end
        C = A + B
        {System.show C}
    end
% 2
% 20
% 22
%--------------------------------------------------------------------------------------------------

declare Enumerate GenerateOdd Filter ListDivisorsOf ListPrimesUntil Enumerate2 Take Primes2 ListDivisorsOf2 in 

%--------------------------------------------------------------------------------------------------

% 2
fun {Enumerate Start End} Stream MakeStream in
    proc {MakeStream Tail Start End} NextTail in 
        if End - Start == ~1 then 
            Tail = nil 
        else 
            Tail = Start | NextTail 
            {MakeStream NextTail ( Start + 1 ) End}
        end 
    end
    thread Tail in 
        Stream = Start | Tail
        {MakeStream Tail (Start + 1) End }
    end
    Stream
end

fun {Filter List P}
    case List of Head|Tail then 
        if {P Head} then Head|{Filter Tail P} else {Filter Tail P} end
    else 
        nil
    end
end

local A in 
    % Need to make sure that the entire stream is calculated before printing it
    A = {Enumerate 1 5}
    {Delay 100}
    {System.show A}
end

fun {GenerateOdd Start End} All Odd in 
    All = {Enumerate Start End}
    thread Odd = {Filter All fun {$ N} {Int.'mod' N 2} == 1 end} end 
    Odd
end 

local A in 
    % Need to make sure that the entire stream is calculated before printing it
    A = {GenerateOdd 1 4}
    {Delay 100}
    {System.show A}
end
%--------------------------------------------------------------------------------------------------

% 3
fun {ListDivisorsOf Number} All Divs in
    All = {Enumerate 1 Number}
    thread Divs = {Filter All fun {$ N} {Int.'mod' Number N} == 0 end} end 
    Divs
end

local A in 
    % Need to make sure that the entire stream is calculated before printing it
    A = {ListDivisorsOf 1}
    {Delay 100}
    {System.show A}
end

fun {ListPrimesUntil N} All Primes in
    All = {Enumerate 1 N}
    thread Primes = {Filter All fun {$ N} {List.length {ListDivisorsOf N}} == 2 end} end
    Primes
end

% Could make abstract this into a stream filter probably

local A in 
    % Need to make sure that the entire stream is calculated before printing it
    A = {ListPrimesUntil 10}
    {Delay 100}
    {System.show A}
end

%--------------------------------------------------------------------------------------------------

% 4

% Take to view results 
fun {Take N List}
    case N of 0 then nil else case List of Head|Tail then Head | {Take ( N-1 ) Tail } end end 
end

% Lazy enumerate implementation 
fun {Enumerate2} Enumerate2Internal in 
    fun lazy {Enumerate2Internal N}
        N | {Enumerate2Internal N+1}
    end
    {Enumerate2Internal 1}
end

{System.show {Take 100 {Enumerate2}}}

% lazy divisor list 
fun lazy {ListDivisorsOf2 N}
    {Filter {Take N{Enumerate2 }} fun {$ M} {Int.'mod' N M} == 0 end}
end

% lazy prime generator
fun lazy {Primes2} 
    {Filter {Enumerate2} fun {$ N} {List.length {ListDivisorsOf2 N}}==2 end}
end


{System.show {Take 100 {Primes2}}}