/******************************************************
 * A multi-line Javadoc-like comment about my grammar *
 ******************************************************/
grammar Grammar;

@header{
package run.parser;
}

program : PROG ID EOL declaration               #programStart
        ;


declaration : var? procedure? function? block                       #declarations;   


procedure : PROCEDUR ID OPEN (variavelF)* CLOSE EOL var? block    #procedur3
          ;

function : FUNCTION ID OPEN (variavelF)+ CLOSE POINTS types EOL var? block     #functi0n;

block : BEGIN (block2)* END                                  #bloco
      ;

block2   : write EOL                                      #blockWrite
        | read  EOL                                       #blockRead
        | attr  EOL                                      #blockAttr
        | expr  EOL                                      #blockExp
        | cond                                           #blockCond
        | whil3                                          #blockWhile
        | f0r                                            #blockf0r
        ;

whil3 : WHILE condExpr DO x=block                   #whilex;

f0r : FOR OPEN attr? EOL condExpr EOL attr? CLOSE block bl=block at=attr            #forex; 


cond    : IF '('condExpr')' THEN b1=block                     #condIf
        | IF '('condExpr')' THEN b1=block ELSE b2=block       #condIfElse 
        ;

condExpr: expr                                           #condExpresion
        | expr relop=('>'|'<'|'=='|'>='|'<=') expr       #condRelOp
        ;


write   : WRITE OPEN STR CLOSE                                      #writeSTR
        | WRITE OPEN expr CLOSE                                     #writeEXP
        | WRITELN OPEN STR CLOSE                                    #writelnSTR
        | WRITELN OPEN expr CLOSE                                   #writelnEXP
        ;

read    : READ OPEN ID CLOSE                                   #readVar
        ;

attr    : ID IS expr                              #attrExpr
        ;

expr    : expr1 '+' expr                                 #exprPlus
        | expr1 '-' expr                                 #exprMinus
        | expr1                                          #expr1Empty
        ;

expr1   : expr2 '*' expr                                 #expr1Mult
        | expr2 '/' expr                                 #expr1Div
        | expr2                                          #expr2Empty
        ;

expr2   : '(' expr ')'                                   #expr2Par
        | NUM                                            #expr2Num
        | ID                                            #expr2Id
        | STR                                           #expr2Str
        | booleanex                                     #exprBool
        ;

booleanex : TRUE                                          #exprTrue
          | FALSE                                         #exprFalse
          ;  

var : VAR (variavel1)+                                      #varVAR
    ;

variavel1 : ID (',' ID)* POINTS types EOL         #varDeclaration
          ;

variavelF : ID  (',' ID)* POINTS types                               #varFunc
          ;

types : CHAR                                             #typeChar
      | INT                                              #typeInt
      | FLT                                              #typeFloat
      | STRING                                           #typeString
      | INTEGER                                          #typeInteger
      | booleanex                                          #typeBoolean
      ;


//TOKENS
PROG    : 'program';
FOR     : 'for';
VAR     : 'var';
DOT     : '.';
IF      : 'if';
ELSE    : 'else';
OR      : 'or';
AND     : 'and';
NOT     : 'not';
THEN    : 'then';
OF      : 'of';
WHILE   : 'while';
DO      : 'do';
BEGIN   : 'begin';
END     : 'end;';
TRUE    : 'true';
FALSE   : 'false';
GT      : '>' ;
LT      : '<' ;
EQ      : '==';
GE      : '>=';
LE      : '<=';                         
FUNCTION: 'function'; 
PROCEDUR: 'procedure';                                
NE      : '<>';
PLUS    : '+' ;
MINUS   : '-' ;
MULT    : '*' ;
DIV     : '/' ;
OPEN    : '(' ;
CLOSE   : ')' ;
OPEN_C  : '[' ;
CLOSE_C : ']' ;
IS      : ':=' ;
POINTS  : ':';
EOL     : ';' ;
WRITE   : 'write' ;
READ    : 'read' ;
READLN  : 'readln';
WRITELN : 'writeln';
CHAR    : 'char';
STRING  : 'string';
NUM     : [0-9]+ ;
INT     : 'int';
INTEGER : 'Integer';
FLT     : 'float';
BOL     : 'boolean';
ID      : [a-zA-Z][a-zA-Z0-9_]*;
STR     : '"' ('\\' ["\\] | ~["\\\r\n])* '"';
JUMP      : [\n\r \t]+ -> skip;
