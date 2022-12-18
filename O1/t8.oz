declare Push Peek Pop

% a

fun {Push List Element}
    Element | List
end

{Show {Push [2 3 4] 1}}

% b

fun {Peek List}
    case List of Head|_ then 
        Head 
    else 
        nil 
    end 
end

{Show {Peek [1 2 3]}}

% c

fun {Pop List}
    case List of _|Tail then 
        Tail 
    else 
        nil 
    end 
end

{Show {Pop [1 2 3]}}
