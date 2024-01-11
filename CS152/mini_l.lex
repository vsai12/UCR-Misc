%{
	#include<stdio.h>
	#include<stdlib.h>
	int numInt,numOp,numParen,numEqual,numFloat = 0;
%}



DIGIT [0-9]
OPERATION ["+","\-","*","/"]
EQUAL =
PARENTHESIS [(,)]


%%

[ \t]+	{}
{DIGIT}+ {printf("%d\n", atoi(yytext)); numInt++;}
{DIGIT}*"."{DIGIT}+ {printf("%g\n",atof(yytext)); numFloat++;}
{OPERATION} {printf("%s\n",yytext); numOp++;}
{EQUAL} {printf("%s\n",yytext); numEqual++;}
{PARENTHESIS} {printf("%s\n",yytext); numParen++;}
{DIGIT}*	{printf("=> %s\n", yytext);}
.		{printf("Error: unrecognized token\n"); exit(1);}

%%
int yywrap(void) {return 1;}

/*int main( int argc, char **argv )
{
    ++argv, --argc;  // skip over program name
    if(argc > 0) 
	yyin = fopen(argv[0], "r");
    else 
        yyin = stdin;
    yylex();
    printf("# of integers = %d\n# of operators = %d\n# of parenthesis = %d\n# of equal signs = %d\n# of floats = %d\n",
                numInt, numOp, numParen, numEqual, numFloat);
}*/
