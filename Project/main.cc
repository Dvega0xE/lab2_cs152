#include "includes.h"

int yyparse();

// Main method
int main(int argc, char **argv)
{
    // Open file if possible.
    if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
    {
        cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
        return 1;
    }
    // Call parser to begin.
    yyparse();
    return 0;
}