/******************************************************
 * A multi-line Javadoc-like comment about my grammar *
 ******************************************************/
grammar Grammar;

@header{
package run.parser;
}

program : PROG ID EOL declaration               #programStart
        ;


declaration : var? functions? block                       #declarations;   


functions : FUNCTION ID OPEN (variavelF)* CLOSE EOL var? block    #function
          ;

block : BEGIN (block2)* END                                  #bloco
      ;

block2   : write EOL                                      #blockWrite
        | read  EOL                                       #blockRead
        | attr  EOL                                      #blockAttr
        | expr  EOL                                      #blockExp
        | cond                                           #blockCond
        | whil3                                          #blockWhile
        ;

whil3 : WHILE condExpr DO x=block                   #whilex;

//f0r

//writeln

//array

cond    : IF '('condExpr')' THEN b1=block                     #condIf
        | IF '('condExpr')' THEN b1=block ELSE b2=block       #condIfElse 
        ;

condExpr: expr                                           #condExpresion
        | expr relop=('>'|'<'|'=='|'>='|'<=') expr       #condRelOp
        ;


write   : WRITE OPEN STR CLOSE                                      #writeSTR
        | WRITE OPEN expr CLOSE                                     #writeEXP
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
        ;

var : VAR variavel1                                      #varVAR
    ;

variavel1 : ID  POINTS types EOL (variavel1)*         #varDeclaration
          | ID ',' variavel1                       #varComma
          ;

variavelF : ID  POINTS types                               #varFunc
          | ID ',' variavelF                               #varFuncComma
          ;

types : CHAR                                             #typeChar
      | INT                                              #typeInt
      | FLT                                              #typeFloat
      | STRING                                           #typeString
      | BOL                                              #typeBol
      | INTEGER                                          #typeInteger
      ;


//TOKENS
PROG    : 'program';
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
FOR     : 'for';
DO      : 'do';
BEGIN   : 'begin';
END     : 'end;';
GT      : '>' ;
LT      : '<' ;
EQ      : '==';
GE      : '>=';
LE      : '<=';                         
FUNCTION: 'procedure';                                 
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
