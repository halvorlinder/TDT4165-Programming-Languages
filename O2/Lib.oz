declare Length Take Drop Append Member Position FirstMatchIndex Subscript Reverse Push Peek Pop

fun {Length List}
    case List of _|Tail then 
        1 + {Length Tail}
    else 
        0
    end
end

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

fun {Append List1 List2}
    case List1 of Head|Tail then 
        Head | {Append Tail List2}
    else 
        List2
    end
end

fun {Member List Element}
    case List of Head|Tail then 
        { Or Head==Element {Member Tail Element} }
    else 
        false
    end
end

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

fun {FirstMatchIndex List Pred} FirstMatchIndexInner in 
    fun {FirstMatchIndexInner List Pred Count }
        case List of Head | Tail then 
            if {Pred Head} then 
                Count
            else 
                {FirstMatchIndexInner Tail Pred ( Count+1 )}
            end 
        else 
            ~1
        end 
    end 
    {FirstMatchIndexInner List Pred 0}
end 

fun {Subscript List Index}
    case List of Head | Tail then 
        if Index==0 then 
            Head 
        else 
            {Subscript Tail ( Index-1 )}
        end
    else 
        raise illFormedExpr(Index) end
    end
end
   
fun {Reverse List} Aux in 
    fun {Aux List Acc}
        case List of Head | Tail then 
            { Aux Tail (Head | Acc) } 
        else 
            Acc
        end
    end 
    {Aux List nil}
end

fun {Push List Element}
    Element | List
end

fun {Peek List}
    case List of Head|_ then 
        Head 
    else 
        nil 
    end 
end

fun {Pop List}
    case List of _|Tail then 
        Tail 
    else 
        nil 
    end 
end