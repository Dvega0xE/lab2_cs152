/*C Declarations*/
%{
#include "includes.h"
#include <stdlib.h>
#define YYSTYPE string
void yyerror(const char* s);
int yylex(void);
string productionString;
%}


/*Bison Declarations*/
%union{
	int num;
	string* aString;
}

%error-verbose
%start declaration

%token <int_val> NUMBER
%token <string> IDENTIFIER

%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token READ
%token WRITE
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%left  AND
%left  OR
%right NOT
%token TRUE
%token FALSE
%token RETURN

%left SUB
%left ADD
%left MULT
%left DIV
%left MOD

%left EQ
%left LT
%left GT
%left LTE
%left GTE
%left NEQ

%token SEMICOLON
%token COLON
%token L_PAREN
%token R_PAREN
%left  ASSIGN
%token COMMA
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET

/* Types */
%type <string> ident

%%
/*Grammar Rules*/
declaration: 	identifiers COLON INTEGER {printf("declaration -> identifiers COLON INTEGER \n");}
		| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER \n");}
;
identifiers:	ident COMMA identifiers {printf("identifiers -> ident COMMA identifiers \n");}
		| ident {printf("identifiers -> ident\n");}
;
ident:		IDENTIFIER {printf("ident -> IDENT \n");}
;


%%
/*Addtional Code*/
void yyerror(const char* s){
	extern int currentLine;
	extern char* yytext;
	printf("ERROR: %s at symbol \"%s\" on line %d\n", s, yytext, currentLine);
	exit(1);
}
