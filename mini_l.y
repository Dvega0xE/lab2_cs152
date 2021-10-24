/*C Declarations*/
%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* s);

%}

/*Bison Declarations*/
%union{
	int num;
	char* ident;
}

%error-verbose
%start program

%token <num> NUMBER
%token <ident> IDENTIFIER

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

%%
/*Grammar Rules*/
program:	function program {} 
		| /*epsilon*/ {}
;

function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS declaration_loop END_PARAMS BEGIN_LOCALS declaration_loop END_LOCALS BEGIN_BODY statement_loop END_BODY {

}
;

declaration_loop: 	declaration SEMICOLON declaration_loop {}
			| /*epsilon*/ {}
;

statement_loop: 	statement SEMICOLON statement_loop {}
			| /*epsilon*/ {}
;

declaration: 	identifier_loop COLON ARRAY L_PAREN NUMBER R_PAREN OF INTEGER {}
		| INTEGER {}
;

identifier_loop:	COMMA identifier_loop {}
			| COLON {}
;

statement1: 	var ASSIGN expression {}
;

statement2: 
;

statement3:
;

statement4: 
;

statement5: 
;

statement6: 
;

statement7: 
;

statement8: 
;

statement: 
;

bool_expr: 
;

relation_and_expr: 
;

relation_expr: 
;

relation_exprS: 
;

comp: 
;

expression: 
;

multiplicative_expr: 
;

term: 
;

term1: 
;

term2: 
;

expression_loop: 
;

var: 
;

%%
/*Addtional Code*/
void yyerror(const char* s){
	extern int currentLine;
	extern char* yytext;
	printf("ERROR: %s at symbol \"%s\" on line %d\n", s, yytext, currentLine);
	exit(1);
}
