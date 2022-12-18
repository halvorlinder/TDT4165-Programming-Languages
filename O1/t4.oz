declare Max PrintGreater

fun {Max Number1 Number2}
    if Number1 < Number2 then 
        Number2
    else 
        Number1
    end
end

proc {PrintGreater Number1 Number2}
    {Show{Max Number1 Number2}}
end


{PrintGreater 2 3}