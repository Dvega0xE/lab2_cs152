/*C Declarations*/
%{
#include "includes.h"
#include <stdlib.h>
#define YYPARSE_PARAM scanner
#define YYLEX_PARAM   scanner
void yyerror(const char* s);
int yylex(void);

%}


/*Bison Declarations*/
%union{
	int num;
	char* aString;
}

%error-verbose
%start program

%token <num> NUMBER
%token IDENTIFIER
%type  <aString> IDENTIFIER

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


%%
/*  Grammar Rules */
/* (In the order they appear on the syntaxt diagram, https://www.cs.ucr.edu/~dtan004/proj2/syntax.html */
program:	function program {printf("program -> function program \n");}
		| {printf("program -> Empty \n");} /* EMPTY ONE */
;

declaration: 	identifiers COLON INTEGER {printf("declaration -> identifiers COLON INTEGER \n");}
		| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER \n");}
;
identifiers:	ident COMMA identifiers {printf("identifiers -> ident COMMA identifiers \n");}
		| ident {printf("identifiers -> ident\n");}
;
ident:		IDENTIFIER {printf("ident -> IDENT %s\n", $1);}
;

function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS parameters {printf("function -> FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS parameters \n");}
;
parameters: 	declaration SEMICOLON parameters {printf("parameters -> declaration SEMICOLON parameters \n");}
		| END_PARAMS BEGIN_LOCALS locals {printf("parameters -> END_LOCALS BEGIN_LOCALS locals \n");}
;
locals:		declaration SEMICOLON locals {printf("locals -> declaration SEMICOLON locals \n");}
                | END_LOCALS BEGIN_BODY bstatements {printf("locals -> END_LOCALS BEGIN_BODY bstatements \n");}
;
bstatements:	statement SEMICOLON bstatements {printf("bstatements -> statement SEMICOLON bstatements \n");}
		| statement SEMICOLON END_BODY {printf("bstatements -> statement SEMICOLON END_BODY \n");}

statement1:	var ASSIGN expression {printf("statement1 -> var ASSIGN expression \n");}
;
statement2:	IF bool_expr THEN statement_loop {printf("statement2 -> IF bool_expr THEN statement_loop \n");}
		| ELSE statement_loop ENDIF {printf("statement2 -> ELSE statement_loop ENDIF \n");}
;
statement3:	WHILE bool_expr BEGINLOOP statement_loop ENDLOOP {printf("statement3 -> WHILE bool_expr BEGINLOOP statement_loop ENDLOOP \n");}
;
statement4:	DO BEGINLOOP statement_loop ENDLOOP WHILE bool_expr {printf("statement4 -> DO BEGINLOOP statement_loop ENDLOOP WHILE bool_expr \n");}
;
statement5:	READ var_loop {printf("statement5 -> READ var_loop \n");}
;
var_loop:	COMMA var var_loop {printf("var_loop -> COMMA var var_loop \n");}
		| {printf("var_loop -> epsilon \n");} /*epsilon*/
;
statement6:	WRITE var_loop {printf("statement6 -> WRITE var_loop \n");} 
;
statement7:	CONTINUE {printf("statement7 -> CONTINUE \n");}
;
statement8:	RETURN expression {printf("statement8 -> RETURN expression \n");}
;
statement:	statement1 
		| statement2
		| statement3
		| statement4
		| statement5
		| statement6
		| statement7
		| statement8
;
bool_expr:	relation_and_expr OR relation_and_expr {printf("bool_expr -> relation_and_expr OR relation_and_expr \n");}
		| {printf("bool_expr -> epsilon \n");} /*epsilon*/
;
relation_and_expr:	relation_expr AND relation_expr {printf("relation_and_expr -> relation_expr AND relation_expr \n");}
			| {printf("relation_and_expr -> epsilon \n");} /*epsilon*/
;
relation_expr:	NOT relation_exprS {printf("relation_expr -> NOT relation_exprS \n");}
		| relation_exprS {printf("relation_expr -> relation_exprS \n");}
;
relation_exprS:	expression comp expression {printf("relation_exprS -> expression comp expression \n");}
		| TRUE {printf("relation_exprS -> TRUE \n");}
		| FALSE {printf("relation_exprS -> FALSE \n");}
		| L_PAREN bool_expr R_PAREN {printf("relation_exprS ->  L_PAREN bool_expr R_PAREN \n");}
;
comp:	EQ {printf("comp -> EQ \n");}
	| NEQ {printf("comp -> NEQ \n");}
	| LT {printf("comp -> LT \n");}
	| GT {printf("comp -> GT \n");}
	| LTE {printf("comp -> LTE \n");}
	| GTE {printf("comp -> GTE \n");}
;
expression:	mult_expr ADD mult_expr {printf("expression -> mult_expr ADD mult_expr \n");}
		| SUB mult_expr {printf("expression -> SUB mult_expr \n");}
		| {printf("expression -> epsilon \n");} /*epsilon*/
;
mult_expr:	term MULT term {printf("mult_expr -> term MULT term \n");}
		| DIV term {printf("mult_expr -> DIV term \n");}
		| MOD term {printf("mult_expr -> MOD term \n");}
		| {printf("mult_expr -> epsilon \n");} /*epsilon*/
;
term:	SUB term1 {printf("term -> SUB term1 \n");}
	| term1 {printf("term -> term1 \n");}
	| term2 {printf("term -> term2 \n");}
;
term1:	var {printf("term1 -> var \n");}
	| NUMBER {printf("term1 -> NUMBER \n");}
	| L_PAREN expression R_PAREN {printf("term1 -> L_PAREN expression R_PAREN \n");}
;
term2:	IDENTIFIER L_PAREN expression expression_loop R_PAREN {printf("term2 -> IDENTIFIER L_PAREN expression expression_loop R_PAREN \n");}
;
expression_loop:	COMMA expression {printf("expression_loop -> COMMA expression \n");}
			| {printf("expression_loop -> epsilon \n");} /*epsilon*/
;
var:	IDENTIFIER {printf("var -> IDENTIFIER \n");}
	| IDENTIFIER L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENTIFIER L_SQUARE_BRACKET expression R_SQUARE_BRACKET \n");}
;

%%
/*Addtional Code*/
void yyerror(const char* s){
	extern int currentLine;
	extern char* yytext;
	printf("ERROR: %s at symbol \"%s\" on line %d\n", s, yytext, currentLine);
	exit(1);
}
