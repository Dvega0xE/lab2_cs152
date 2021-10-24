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
%start declaration

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
declaration: 	IDENTIFIER declaration2 {printf("declaration -> IDENTIFIER $1 declaration2 -> ");}
;
declaration2: 	COMMA declaration {printf("COMMA ");}
		| declaration3 {printf("declaration3 -> ");}
;
declaration3: 	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER \n");}
		| INTEGER {printf("INTEGER \n");}
;

%%
/*Addtional Code*/
void yyerror(const char* s){
	extern int currentLine;
	extern char* yytext;
	printf("ERROR: %s at symbol \"%s\" on line %d\n", s, yytext, currentLine);
	exit(1);
}

// prototype of bison-generated parser function
int yyparse();

int main(int argc, char **argv)
{
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }

  yyparse();

  return 0;
}
