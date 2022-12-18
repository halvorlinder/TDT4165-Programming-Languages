declare Length Take Drop Append Member Position

% a
fun {Length List}
    case List of _|Tail then 
        1 + {Length Tail}
    else 
        0
    end
end

{Show {Length [1 2 3 4 5]}}

% b 
fun {Take List Count}
    if Count > 0 then 
        case List of Head|Tail then 
            Head | {Take Tail (Count - 1)}
        else 
            nil
        end
    else 
        nil 
    end
end

{Show {Take [1 2 3 4 5] 4}}
{Show {Take [1 2 3 4 5] 5}}
{Show {Take [1 2 3 4 5] 6}}

% c 
fun {Drop List Count}
    if Count > 0 then 
        case List of _|Tail then 
            {Drop Tail (Count - 1)}
        else 
            nil
        end
    else 
        List 
    end
end

{Show {Drop [1 2 3 4 5] 4}}
{Show {Drop [1 2 3 4 5] 5}}
{Show {Drop [1 2 3 4 5] 6}}


% d 
fun {Append List1 List2}
    case List1 of Head|Tail then 
        Head | {Append Tail List2}
    else 
        List2
    end
end

{Show {Append [1 2 3 4 5] [6 7 8]}}

% e 
fun {Member List Element}
    case List of Head|Tail then 
        { Or Head==Element {Member Tail Element} }
    else 
        false
    end
end

{Show {Member [1 2 3 4 5] 3}}
{Show {Member [1 2 3 4 5] 6}}

% f 
fun {Position List Element} 
    case List of Head|Tail then 
        if Head==Element then 
            0
        else 
            1 + { Position Tail Element} 
        end
    else 
        0
    end
end

{Show {Position [1 2 3 4 5] 3}}
{Show {Position [1 2 3 4 5] 6}}