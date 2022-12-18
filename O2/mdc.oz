%Not sure what to do about the paths here. They need to be changed for the code to run from another folder
\insert '/home/halvorlinder/NTNU/Programming_Languages/O2/Lib.oz'
\insert '/home/halvorlinder/NTNU/Programming_Languages/O2/helpers.oz'

declare Lex Tokenize TokenMapping Interpret OperatorMapping CommandMapping UnaryMapping WholeStackMapping ExpressionTree

% Splits a string on spaces 
fun {Lex Input}
    { String.tokens Input & } 
end

% Maps a single lexeme to its corresponding token (as a record)
fun {TokenMapping Lexeme}
    if { String.isFloat Lexeme } then number({ String.toFloat Lexeme }) else 
        case Lexeme of "*" then operator(type:multiply)
        [] "+" then operator(type:plus)
        [] "-" then operator(type:minus)
        [] "/" then operator(type:divide)
        [] "p" then command(type:print)
        [] "d" then nonConsumingUnary(type:duplicate)
        [] "i" then unary(type:flip)
        [] "c" then wholeStack(type:clear)
        else 
            null()
        end
    end
end

% Maps a list of lexemes to a list of tokens 
fun {Tokenize Lexemes}
    {Map Lexemes TokenMapping} 
end

% The <TokenType>Mapping functions map tokens to the Functions that they represent 

%Binary operator that consumes to elements
fun {OperatorMapping Operator}
    case Operator of multiply then Mul
    [] plus then Add 
    [] minus then Sub
    [] divide then Div
    else 
        raise illFormedExpr(Operator) end
    end
end

% fun {NumberMapping Number}
%     case Number of number(X) then 
%         X
%     else 
%         raise illFormedExpr(Number) end
%     end
% end

% Command that takes the entire stack as input but does not mutate
fun {CommandMapping Command}
    case Command of print then Print
    else 
        raise illFormedExpr(Command) end
    end
end

% Unary operator that does not consume the element it operates on
fun {NonConsumingUnaryMapping Unary}
    case Unary of duplicate then Id
    else 
        raise illFormedExpr(Unary) end
    end
end

% Unary operator that consumes the element it operates on
fun {UnaryMapping Unary}
    case Unary of flip then Flip
    else 
        raise illFormedExpr(Unary) end
    end
end

% Function that maps the stack onto a new stack
fun {WholeStackMapping Function}
    case Function of clear then Clear
    else 
        raise illFormedExpr(Function) end
    end
end

% Interprets a list of tokens
fun {Interpret Tokens} Apply in 
    % Auxillary function that transfers from Tokens to Stack 
    fun {Apply Stack Tokens}
        % Are there more tokens?
        case Tokens of Token | TokensTail then 
            % Match against all cases of tokens, do the function and then call recursively
            case Token of number(X) then 
                {Apply (X | Stack) TokensTail}
            [] operator(type:Operator) then 
                case Stack of A | B | StackTail then 
                    {Apply ({ {OperatorMapping Operator} A B} | StackTail) TokensTail }
                else 
                    raise illFormedExpr("Too small stack") end
                end
            [] command(type:Command) then 
                {{CommandMapping Command } Stack}
                {Apply Stack TokensTail}
            [] nonConsumingUnary(type:Unary) then 
                case Stack of A | StackTail then 
                    {Apply ({ {NonConsumingUnaryMapping Unary} A} | A | StackTail) TokensTail }
                else 
                    raise illFormedExpr("Too small stack") end
                end
            [] unary(type:Unary) then 
                case Stack of A | StackTail then 
                    {Apply ({ {UnaryMapping Unary} A} | StackTail) TokensTail }
                else 
                    raise illFormedExpr("Too small stack") end
                end
            [] wholeStack(type:Function) then 
                {Apply ({ {WholeStackMapping Function} Stack} ) TokensTail }
            else 
                raise illFormedExpr(Token) end
            end
        else 
            Stack 
        end
    end
    % Call the aux
    {Apply nil Tokens}
end

% Creates a tree representsation from a list of tokens
fun {ExpressionTree Tokens} ExpressionTreeInternal in
    % Aux function that transfers from Tokens to ExpressionStack recursively
    fun {ExpressionTreeInternal Tokens ExpressionStack}
        %Are there more tokens? 
        case Tokens of Token | TokensTail then 
            %Number
            case Token of number(N) then 
                {ExpressionTreeInternal TokensTail (N | ExpressionStack)}
            %Operator
            [] operator(type:Operator) then 
                case ExpressionStack of A | B | ExpressionStackTail then 
                    {ExpressionTreeInternal TokensTail (Operator(A B) | ExpressionStackTail)}
                else 
                    raise illFormedExpr("Too small stack") end
                end
            else
                raise illFormedExpr(Token) end
            end
        else 
            % Return top element
            {Peek ExpressionStack }
        end
    end
    {ExpressionTreeInternal Tokens nil}
end

% To convert from postfix to infix, simply make a tree, like the one return from ExpressionTree, and place the operators between its arguments
% instead of in front

% {Show {ExpressionTree {Tokenize {Lex "2 3 + 5 /" }}} }
{Show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 5 + +" }}} }
% {Show {Interpret {Tokenize {Lex "1 2 3 + d i c" }}} }