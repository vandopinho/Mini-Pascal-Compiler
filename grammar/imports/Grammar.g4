/******************************************************
 * A multi-line Javadoc-like comment about my grammar *
 ******************************************************/
grammar Grammar;

@header{
package basicintast.parser;
import basicintast.util.*;
}

program : PROG ID EOL declaration block '.'              #programStmt
        ;

stmt    : var   EOL             #stmtVar
        | write EOL             #stmtWrite
        | read  EOL             #stmtRead
        | attr  EOL             #stmtAttr
        | expr  EOL             #stmtExpr
        | cond                  #stmtCond
        ;

declaration : functions vars
            | vars 
            ;

cond    : IF '('condExpr')' b1=block                   #ifStmt
        | IF '('condExpr')' b1=block ELSE b2=block     #ifElseStmt 
        ;

condExpr: expr                                              #condExpresion
        | expr relop=('>'|'<'|'=='|'>='|'<='|'<>') expr     #condRelOp
        ;

block   : '{' program '}'   #blockStmt
        ;

var     : VR ID DOIS type        
        ;

type    : BOL
        | INT
        | FLT
        | CHAR
        | STRING
        ;

write   : WRITE '(' ID ?')'STR         #writeStr
        | WRITE expr        #writeExpr
        ;

read    : READ VAR          #readVar
        ;

attr    : VAR ':=' expr      #attrExpr
        ;

expr    : expr1 '+' expr    #exprPlus
        | expr1 '-' expr    #exprMinus
        | expr1             #expr1Empty
        ;

expr1   : expr2 '*' expr    #expr1Mult
        | expr2 '/' expr    #expr1Div
        | expr2             #expr2Empty
        ;

expr2   : '(' expr ')'      #expr2Par
        | NUM               #expr2Num
        | VAR               #expr2Var
        ;

//TOKENS
PROG    : 'program';
DOT     : '.';
ID      : [a-zA-Z][a-zA-Z0-9_]*;
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
END     : 'end';
GT      : '>' ;
LT      : '<' ;
EQ      : '==';
GE      : '>=';
LE      : '<=';                         
PCDR    : 'procedure';                                  
NE      : '<>';
PLUS    : '+' ;
MINUS   : '-' ;
MULT    : '*' ;
DIV     : '/' ;
OPEN    : '(' ;
CLOSE   : ')' ;
OPEN_CH : '[' ;
CLOSE_CH: ']' ;
IS      : ':=' ;
DOIS    : ':';
EOL     : ';' ;
WRITE   : 'write' ;
READ    : 'read' ;
READLN  : 'readln';
WRITELN : 'writeln';
CHAR    : 'char';
STRING  : 'string';
NUM     : [0-9]+ ;
INT     : 'int';
FLT     : 'float';
BOL     : 'boolean';
VAR     : [a-zA-Z][a-zA-Z0-9_]*;
VR      : 'var';
STR     : '"' ('\\' ["\\] | ~["\\\r\n])* '"';
WS      : [\n\r \t]+ -> skip;
