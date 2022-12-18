declare Add Mul Sub Div Id Flip Clear Print

%Helper functions that should be trivial to understand

fun {Add A B}
    A + B
end
 
fun {Mul A B}
    A * B
end

fun {Sub A B} 
    A - B
end

fun {Div A B}
    A / B
end

fun {Id A}
    A
end

fun {Flip A}
    A*(~1.0)
end

fun {Clear _}
    nil
end

proc {Print Stack}
    {Show Stack}
end