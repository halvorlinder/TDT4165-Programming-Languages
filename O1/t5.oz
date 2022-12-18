declare Circle

proc {Circle R} A D C PI in
    PI = 355.0/113.0
    A = PI * R * R
    D = 2.0 * R
    C = PI * D
    {Show A}
    {Show D}
    {Show C}
end

{Circle 2.0}
