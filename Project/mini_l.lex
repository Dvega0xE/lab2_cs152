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
"function"	{currentColumn += yyleng;} /* Reserved Words */
"beginparams" 	{currentColumn += yyleng;}
"endparams"     {currentColumn += yyleng;}
"beginlocals" 	{currentColumn += yyleng;}
"endlocals"     {currentColumn += yyleng;}
"beginbody"     {currentColumn += yyleng;}
"endbody"     	{currentColumn += yyleng;}
"integer"   	{yylval.aString = new std::string(yytext); return INTEGER; currentColumn += yyleng;}
"read"     	    {currentColumn += yyleng;}
"write"     	{currentColumn += yyleng;}
"array"	    	{yylval.aString = new std::string(yytext); return ARRAY; currentColumn += yyleng;}
"of"		    {yylval.aString = new std::string(yytext); return OF; currentColumn += yyleng;}
"if"		    {currentColumn += yyleng;}
"then"		    {currentColumn += yyleng;}
"endif"		    {currentColumn += yyleng;}
"else"		    {currentColumn += yyleng;}
"while"		    {currentColumn += yyleng;}
"do"		    {currentColumn += yyleng;}
"beginloop"	    {currentColumn += yyleng;}
"endloop"	    {currentColumn += yyleng;}
"continue"	    {currentColumn += yyleng;}
"and"		    {currentColumn += yyleng;}
"or"		    {currentColumn += yyleng;}
"not"		    {currentColumn += yyleng;}
"true"		    {currentColumn += yyleng;}
"false"		    {currentColumn += yyleng;}
"return"	    {currentColumn += yyleng;}

"-"     {currentColumn += yyleng;} /* Arithmetic Operators */
"+"     {currentColumn += yyleng;}
"*"     {currentColumn += yyleng;}
"/"     {currentColumn += yyleng;}
"%"     {currentColumn += yyleng;}

"=="	{currentColumn += yyleng;} /* Comparison Operators */
"<"	    {currentColumn += yyleng;}
">"	    {currentColumn += yyleng;}
"<="	{currentColumn += yyleng;}
">="	{currentColumn += yyleng;}
"<>"	{currentColumn += yyleng;}

";"     {currentColumn += yyleng;} /* Other Special Symbols */
":"     {currentColumn += yyleng;}
"("     {currentColumn += yyleng;}
")"     {currentColumn += yyleng;}
":="   	{currentColumn += yyleng;}
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