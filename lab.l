%{
        int yylineno;
        #define ID 1;
}%

def (d)(e)(f)

%%
{def}   printf("Se encontró una función.\n");
\n      yylineno++;
.       ;
%%
int main(){
    yylex();
    return 0;
}