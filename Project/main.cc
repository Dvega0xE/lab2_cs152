#include "includes.h"

int yyparse();

// Main method
int main(int argc, char **argv)
{
    // allows for a file or command line arguments
    if (argc >= 2) {
        freopen(argv[1], "r", stdin);
        yyparse();
    } else {
        yyparse();
    }
    return 0;
}