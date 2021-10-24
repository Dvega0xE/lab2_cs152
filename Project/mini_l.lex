%{
    #include "includes.h"
    #include "tok.h"
    int currentLine = 1;        /* Setup Line and Depth tracking variables */
    int currentColumn = 0;
%}

DIGIT		[0-9]
ALPHANUM    [a-zA-Z0-9]
WHITESPACE	[ \t\0]
WHITESPACENL	[\n\r]
INVALIDSTART	[0-9|_][a-zA-Z0-9]*
INVALIDEND	[a-zA-Z][a-zA-Z0-9|_]*[_]
COMMENTS	[##].*


%%
"function"	    {yylval.aString = new std::string(yytext); return FUNCTION; currentColumn += yyleng;} /* Reserved Words */
"beginparams" 	{yylval.aString = new std::string(yytext); return BEGINPARAMS; currentColumn += yyleng;}
"endparams"     {yylval.aString = new std::string(yytext); return ENDPARAMS; currentColumn += yyleng;}
"beginlocals" 	{yylval.aString = new std::string(yytext); return BEGINLOCALS; currentColumn += yyleng;}
"endlocals"     {yylval.aString = new std::string(yytext); return ENDLOCALS; currentColumn += yyleng;}
"beginbody"     {yylval.aString = new std::string(yytext); return BEGINBODY; currentColumn += yyleng;}
"endbody"     	{yylval.aString = new std::string(yytext); return ENDBODY; currentColumn += yyleng;}
"integer"   	{yylval.aString = new std::string(yytext); return INTEGER; currentColumn += yyleng;}
"read"     	    {yylval.aString = new std::string(yytext); return READ; currentColumn += yyleng;}
"write"     	{yylval.aString = new std::string(yytext); return WRITE; currentColumn += yyleng;}
"array"	    	{yylval.aString = new std::string(yytext); return ARRAY; currentColumn += yyleng;}
"of"		    {yylval.aString = new std::string(yytext); return OF; currentColumn += yyleng;}
"if"		    {yylval.aString = new std::string(yytext); return IF; currentColumn += yyleng;}
"then"		    {yylval.aString = new std::string(yytext); return THEN;currentColumn += yyleng;}
"endif"		    {yylval.aString = new std::string(yytext); return ENDIF; currentColumn += yyleng;}
"else"		    {yylval.aString = new std::string(yytext); return ELSE; currentColumn += yyleng;}
"while"		    {yylval.aString = new std::string(yytext); return WHILE; currentColumn += yyleng;}
"do"		    {yylval.aString = new std::string(yytext); return DO; currentColumn += yyleng;}
"beginloop"	    {yylval.aString = new std::string(yytext); return BEGINLOOP; currentColumn += yyleng;}
"endloop"	    {yylval.aString = new std::string(yytext); return ENDLOOP; currentColumn += yyleng;}
"continue"	    {yylval.aString = new std::string(yytext); return CONTINUE; currentColumn += yyleng;}
"and"		    {yylval.aString = new std::string(yytext); return AND; currentColumn += yyleng;}
"or"		    {yylval.aString = new std::string(yytext); return OR; currentColumn += yyleng;}
"not"		    {yylval.aString = new std::string(yytext); return NOT; currentColumn += yyleng;}
"true"		    {yylval.aString = new std::string(yytext); return TRUE; currentColumn += yyleng;}
"false"		    {yylval.aString = new std::string(yytext); return FALSE; currentColumn += yyleng;}
"return"	    {yylval.aString = new std::string(yytext); return RETURN; currentColumn += yyleng;}

"-"     {yylval.aString = new std::string(yytext); return SUB; currentColumn += yyleng;} /* Arithmetic Operators */
"+"     {yylval.aString = new std::string(yytext); return ADD; currentColumn += yyleng;}
"*"     {yylval.aString = new std::string(yytext); return MULT; currentColumn += yyleng;}
"/"     {yylval.aString = new std::string(yytext); return DIV; currentColumn += yyleng;}
"%"     {yylval.aString = new std::string(yytext); return MOD; currentColumn += yyleng;}

"=="	{yylval.aString = new std::string(yytext); return EQ; currentColumn += yyleng;} /* Comparison Operators */
"<"	    {yylval.aString = new std::string(yytext); return LT; currentColumn += yyleng;}
">"	    {yylval.aString = new std::string(yytext); return GT; currentColumn += yyleng;}
"<="	{yylval.aString = new std::string(yytext); return LTE; currentColumn += yyleng;}
">="	{yylval.aString = new std::string(yytext); return GTE; currentColumn += yyleng;}
"<>"	{yylval.aString = new std::string(yytext); return NEQ; currentColumn += yyleng;}

";"     {yylval.aString = new std::string(yytext); return SEMICOLON; currentColumn += yyleng;} /* Other Special Symbols */
":"     {yylval.aString = new std::string(yytext); return COLON; currentColumn += yyleng;}
"("     {yylval.aString = new std::string(yytext); return L_PAREN; currentColumn += yyleng;}
")"     {yylval.aString = new std::string(yytext); return R_PAREN; currentColumn += yyleng;}
":="   	{yylval.aString = new std::string(yytext); return ASSIGN; currentColumn += yyleng;}
","	    {yylval.aString = new std::string(yytext); return COMMA; currentColumn += yyleng;}
"["	    {yylval.aString = new std::string(yytext); return L_SQUARE_BRACKET; currentColumn += yyleng;}
"]"	    {yylval.aString = new std::string(yytext); return R_SQUARE_BRACKET; currentColumn += yyleng;}

[a-zA-Z]({ALPHANUM}|_+{ALPHANUM})*		{yylval.aString = new std::string(yytext); return IDENTIFIER; currentColumn += yyleng;} /* Identifiers */

{DIGIT}+        {yylval.num = atoi(yytext); return NUMBER; currentColumn += yyleng;} /* Numbers */

{WHITESPACE}+ 	{currentColumn += yyleng;} /* WHITESPACE */
{WHITESPACENL}+ {currentColumn = 0; currentLine += 1;} /* WHITESPACENL */

{COMMENTS}	{currentLine += 1; currentColumn = 0;} /*Comments on a single line */

{INVALIDSTART}	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n",
		    currentLine, currentColumn, yytext); exit(1);} /*Invalid identifiers: must start with a letter */

{INVALIDEND}	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",
		    currentLine, currentColumn, yytext); exit(1);} /*Invalid identifiers: cannot end with an underscore */

.		{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n",
                    currentLine, currentColumn, yytext); exit(1);}                        /* Catch anything else */

%%
