%{
        #include<stdio.h>
        #include<stdlib.h>

	int line = 1;
	int col = 1;

%}



DIGIT [0-9]
LETTER [a-zA-Z]

ALPHANUM  [a-zA-Z0-9]
ID {LETTER}(({ALPHANUM}|_)*{ALPHANUM})*


INVALIDID [0-9_]{ID}|{ID}_


%%




[ \t]+  {col += yyleng;}
"\n"	{col = 1; line++;}

"function"	{printf("FUNCTION\n"); col += yyleng;}
"beginparams"      {printf("BEGIN_PARAMS\n"); col += yyleng;}
"endparams"      {printf("END_PARAMS\n"); col += yyleng;}
"beginlocals"      {printf("BEGIN_LOCALS\n"); col += yyleng;}
"endlocals"      {printf("END_LOCALS\n"); col += yyleng;}
"beginbody"      {printf("BEGIN_BODY\n"); col += yyleng;}
"endbody"      {printf("END_BODY\n"); col += yyleng;}
"int"      {printf("INTEGER\n"); col += yyleng;}
"array"      {printf("ARRAY\n"); col += yyleng;}
"of"      {printf("OF\n"); col += yyleng;}
"if"      {printf("IF\n"); col += yyleng;}
"then"      {printf("THEN\n"); col += yyleng;}
"endif"     {printf("ENDIF\n"); col += yyleng;}
"eif"	    {printf("ELSE_IF\n"); col += yyleng;}
"else"      {printf("ELSE\n"); col += yyleng;}
"while"      {printf("WHILE\n"); col += yyleng;}
"do"      {printf("DO\n"); col += yyleng;}
"beginloop"      {printf("BEGINLOOP\n"); col += yyleng;}
"endloop"      {printf("ENDLOOP\n"); col += yyleng;}
"continue"      {printf("CONTINUE\n"); col += yyleng;}
"stop"      {printf("STOP\n"); col += yyleng;}
"cr"      {printf("READ\n"); col += yyleng;}
"cw"      {printf("WRITE\n"); col += yyleng;}
"not"      {printf("NOT\n"); col += yyleng;}
"true"      {printf("TRUE\n"); col += yyleng;}
"false"      {printf("FALSE\n"); col += yyleng;}
"return"      {printf("RETURN\n"); col += yyleng;}

{ID}    {printf("IDENT %s\n", yytext); col += yyleng;}
{DIGIT}+        {printf("NUMBER %d\n", atoi(yytext)); col += yyleng;}
{DIGIT}*"."{DIGIT}+ {printf("FLOAT %g\n",atof(yytext)); col += yyleng;}


"//"	{printf("COMMENT\n"); col += yyleng;}
"/*"	{printf("MULTI-LINE_COMMENT_BEGIN\n"); col += yyleng;}
"*/"    {printf("MULTI-LINE_COMMENT_END\n"); col += yyleng;}

"+"     {return("ADD"); col += yyleng;}
"-"     {return("SUB"); col += yyleng;}
"*"     {return("MUL"); col += yyleng;}
"/"     {return("DIV"); col += yyleng;}
"+="     {printf("PLUS_EQ\n"); col += yyleng;}
"-="     {printf("MIN_EQ\n"); col += yyleng;}
"*="     {printf("MULT_EQ\n"); col += yyleng;}
"/="     {printf("DIV_EQ\n"); col += yyleng;}
"%"	{printf("MOD\n"); col += yyleng;}
"=="	{printf("EQ\n"); col += yyleng;}
"!="	{printf("NEQ\n"); col += yyleng;}
"<"	{printf("LT\n"); col += yyleng;}
">"	{printf("GT\n"); col += yyleng;}
"<="     {printf("LTE\n"); col += yyleng;}
">="     {printf("GTE\n"); col += yyleng;}
"("     {printf("L_PAREN\n"); col += yyleng;}
")"     {printf("R_PAREN\n"); col += yyleng;}
";"     {printf("SEMICOLON\n"); col += yyleng;}
":"     {printf("COLON\n"); col += yyleng;}
","     {printf("COMMA\n"); col += yyleng;}
"["     {printf("L_SQUARE_BRACKET\n"); col += yyleng;}
"]"     {printf("R_SQUARE_BRACKET\n"); col += yyleng;}
"="     {printf("ASSIGN\n"); col += yyleng;}
"{"     {printf("L_CURLY_BRACKET\n"); col += yyleng;}
"}"     {printf("R_CURLY_BRACKET\n"); col += yyleng;}

{INVALIDID}	{printf("Error at line %d. column %d: invalid identifier %s\n", line, col, yytext); yyterminate();}
.       {printf("Error at line %d. column %d: unrecognized symbol %s \n", line, col, yytext); yyterminate();}

%%
int yywrap(void) {return 1;}
/*
int main( int argc, char **argv )
{
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r");
    else
        yyin = stdin;

    yylex();
}*/
