/******************************************************
 * A multi-line Javadoc-like comment about my grammar *
 ******************************************************/
grammar Grammar;

@header{
package run.parser;
import run.util.*;
}

@members {
String tradutor = "";
char open = 123;
char close = 125;
}

program : PROG { tradutor+="#include<iostream>\nusing namespace std;\nint main()"+open+"\n";} ID EOL declaration #programStart
        ;


declaration : var? procedure? function? block                   #declarations;   


procedure : PROCEDUR {tradutor+="void ";}ID {tradutor+=$ID.text;} OPEN {tradutor+="(";} (variavelF)* CLOSE {tradutor+=")\n";} EOL {tradutor+=open+"\n";} var?  block     #procedur3
          ;

function : FUNCTION ID OPEN (variavelF)+ CLOSE POINTS types EOL var? block     #functi0n;

block : BEGIN (block2)* END  {tradutor+="\n return 0;";
                             tradutor+="\n"+close+"\n";
                             ArquivoC.get(tradutor);}  #bloco
      ;

block2   : write EOL                                      #blockWrite
        | read  EOL                                       #blockRead
        | attr  EOL                                      #blockAttr
        | expr  EOL                                      #blockExp
        | cond                                           #blockCond
        | whil3                                          #blockWhile
        | f0r                                            #blockf0r
        ;

whil3 : WHILE condExpr DO x=block   {tradutor+="while(";
                                    tradutor+=")";
                                    tradutor+=open+"\n";
                                    tradutor+=close;}#whilex;

f0r : FOR OPEN attr? EOL condExpr EOL attr? CLOSE block bl=block at=attr {tradutor+="for(";
                                                                          tradutor+=";";
                                                                          tradutor+=";";
                                                                          tradutor+=")"+open;
                                                                          tradutor+=close;}#forex; 


cond    : IF '('condExpr')' THEN b1=block { tradutor+="if(";
                                            tradutor+=")"+open;
                                            tradutor+=close;}#condIf

        | IF '('condExpr')' THEN b1=block ELSE b2=block {tradutor+="if(";
                                                         tradutor+=")"+open;
                                                         tradutor+=close;
                                                         tradutor+="else"+open;
                                                         tradutor+=close;}#condIfElse 
        ;

condExpr: expr                                           #condExpresion
        | expr relop=('>'|'<'|'=='|'>='|'<=') expr {tradutor+=$relop.text;}       #condRelOp
        ;


write   : WRITE OPEN STR CLOSE   {tradutor+="cout<<"+$STR.text+";" + "\n";}#writeSTR
        | WRITE OPEN {tradutor+="cout<<";} expr {tradutor+=";";} CLOSE  #writeEXP
        | WRITELN OPEN STR CLOSE  {tradutor+="cout<<"+$STR.text+"<<endl;"+"\n";}#writelnSTR
        | WRITELN OPEN {tradutor+="cout<<";} expr {tradutor+="<<endl;"+"\n";} CLOSE #writelnEXP
        ;

read    : READ OPEN ID CLOSE {tradutor+="cin>>"+$ID.text+";"+"\n";} #readVar
        ;

attr    : ID {tradutor+=$ID.text+"=";} IS expr {tradutor+=";"+"\n";}#attrExpr
        ;

expr    : expr1 '+' {tradutor+="+";}expr #exprPlus
        | expr1 '-' {tradutor+="-";}expr #exprMinus
        | expr1                          #expr1Empty
        ;

expr1   : expr2 '*' expr  {tradutor+="*";}  #expr1Mult
        | expr2 '/' expr  {tradutor+="/";}  #expr1Div
        | expr2                             #expr2Empty
        ;

expr2   : '(' expr ')'                #expr2Par
        | NUM   {tradutor+=$NUM.text;}#expr2Num
        | ID    {tradutor+=$ID.text;} #expr2Id
        | STR   {tradutor+=$STR.text;}#expr2Str
        | booleanex                   #exprBool
        ;

booleanex : TRUE   {tradutor+=$TRUE.text;}#exprTrue
          | FALSE  {tradutor+=$FALSE.text;}#exprFalse
          ;  

var : VAR (variavel1)+                                      #varVAR
    ;

variavel1 : ID (',' ID)* POINTS types EOL {tradutor+=$ID.text+";"+"\n";}         #varDeclaration
          ;

variavelF : ID  (',' ID)* POINTS types   {tradutor+=$ID.text;}                           #varFunc
          ;

types : CHAR                  {tradutor+="char ";}                           #typeChar
      | FLT                   {tradutor+="float ";}                           #typeFloat
      | STRING                {tradutor+="string ";}                          #typeString
      | INTEGER               {tradutor+="int ";}                           #typeInteger
      | booleanex             {tradutor+="bool ";}                             #typeBoolean
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
WRITELN : 'writeln';
CHAR    : 'char';
STRING  : 'string';
NUM     : [0-9]+ ;
INTEGER : 'integer';
FLT     : 'float';
BOL     : 'boolean';
ID      : [a-zA-Z][a-zA-Z0-9_]*;
STR     : '"' ('\\' ["\\] | ~["\\\r\n])* '"';
JUMP      : [\n\r \t]+ -> skip;
