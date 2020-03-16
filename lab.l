%{ 
      #include <stdio.h>
      #include <string.h>
      #include <ctype.h>
      #include <stdlib.h>
      int p_claves=0;
      int keys=0;
      int num=0;
      int op=0;
      int str=0;
      int deli=0;
      int comm=0;
      int count = 0;
      int delimitadoresstrings=0; 
      int idActual=0;
      FILE* fp; 
      char *arr[50] = {""};
      int ids=0;
%} 
  
LETRA [a-zA-Z]
DIGITO [0-9]
VARIABLE {LETRA}({LETRA}|{DIGITO})*
FLOAT ([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?
INT ([0-9]+)([eE][-+]?[0-9]+)?
LONG {INT}(L|l)
IMAGINARY ({INT}|{FLOAT})(J|j)
STRING ("\""|"\'")([^\n\*]([.])*)*("\""|"\'")
KEYWORD   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|false
OPERATOR "+"|"-"|"*"|"**"|"/"|"//"|"%"|"<<"|">>"|"&"|"|"|"^"|"~"|"<"|">"|"<="|">="|"=="|"!="|"<>"
DELIMITADORESCHAR "("|")"|"["|"]"|"="|";"|","|":"|"."

COMENTARIO "#"
NUMBER ({FLOAT}|{INT}|{LONG}|{IMAGINARY})

%%

">>=" {fprintf(yyout,"mayor_ig=%s",yytext);}
"<<=" {fprintf(yyout,"menor_ig=%s",yytext);}
"+=" {fprintf(yyout,"suma_asig=%s",yytext);}
"-=" {fprintf(yyout,"resta_asig=%s",yytext);}
"*=" {fprintf(yyout,"mult_asig=%s",yytext);}
"/=" {fprintf(yyout,"div_asig=%s",yytext);}
"//=" {fprintf(yyout,"floordiv=%s",yytext);}
"&=" {fprintf(yyout,"andigual=%s",yytext);}
"|=" {fprintf(yyout,"origual=%s",yytext);}
"^=" {fprintf(yyout,"expigual=%s",yytext);}
"**=" {fprintf(yyout,"exponente=%s",yytext);}
"%=" {fprintf(yyout,"modulo=%s",yytext);}


{KEYWORD} {
      int i=0;
      while(yytext[i]) {
            fprintf(yyout,"%c",toupper(yytext[i]));
            i++;
      }
   p_claves++;
}

{OPERATOR} {fprintf(yyout,"op=%s",yytext);op++;}

{NUMBER} {fprintf(yyout,"nro=%s",yytext);num++;}

{VARIABLE} {
   int i;
   int pos=-1;
   int result;
    for(i = 0; i < ids; i++){ 
       char * token = strtok(arr[i], "\n");
       result = strcmp(token, yytext);
         if(result==0){
            printf("Entra\t %s es igual a %s\n", token, yytext);
            pos=i;
        }
        printf("Posicion: %d\n", pos);
    }

    if(pos==-1){
       arr[ids]=yytext;
       fprintf(yyout,"id%d=%s",ids,yytext);
       ids++;
    }
    else{
       fprintf(yyout,"id%d=%s\n",pos,yytext);
    }
}

{STRING} {fprintf(yyout,"str=%s",yytext);str++;}
{DELIMITADORESCHAR} {
   switch ((char)*yytext)
   {
      case '(':
         fprintf(yyout,"parabre=%s",yytext);
         break;
      case ')':
         fprintf(yyout,"parcierr=%s",yytext);
         break;
      case '[':
         fprintf(yyout,"corabre=%s",yytext);
         break;
      case ']':
         fprintf(yyout,"corcierr=%s",yytext);
         break;
      case '=':
         fprintf(yyout,"asiggn= %s",yytext);
         break;
      case ';':
         fprintf(yyout,"puntocoma=%s",yytext);
         break;
      case ',':
         fprintf(yyout,"coma=%s",yytext);
         break;
      case ':':
         fprintf(yyout,"dospunt=%s",yytext);
         break;
      /*case '>>=':
         fprintf(yyout,"mayor_ig=%s",yytext);
         break;
      case '<<=':
         fprintf(yyout,"menor_ig=%s",yytext);
         break;
      case '+=':
         fprintf(yyout,"suma_asig=%s",yytext);
         break;
      case '-=':
         fprintf(yyout,"resta_asig=%s",yytext);
         break;
      case '*=':
         fprintf(yyout,"mult_asig=%s",yytext);
         break;
      case '/=':
         fprintf(yyout,"div_asig=%s",yytext);
         break;
      case '//=':
         fprintf(yyout,"floordiv=%s",yytext);
         break;
      case '&=':
         fprintf(yyout,"andigual=%s",yytext);
         break;
      case '|=':
         fprintf(yyout,"origual=%s",yytext);
         break;
      case '^=':
         fprintf(yyout,"expigual=%s",yytext);
         break;
      case '**=':
         fprintf(yyout,"exponente=%s",yytext);
         break;
      case '%=':
         fprintf(yyout,"modulo=%s",yytext);
         break;*/
   }
}
[\n] {fprintf(yyout,"\n");}
%% 
  
int yywrap(){} 

int main(){ 
  
      extern FILE *yyin, *yyout;
      /*char filename[50]; 
      printf("Enter the filename: \n"); 
      scanf("%s",filename); 
      fp = fopen(filename,"r"); 
      yyin = fp;*/

      yyin = fopen("prueba1.py", "r");
      yyout = fopen("output.txt", "w");

      yylex(); 
      return 0; 
} 
