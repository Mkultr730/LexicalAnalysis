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
VARIABLE {LETRA}({LETRA}|{DIGITO}|"-"|"_")*
FLOAT ("-")?({DIGITO}*\.{DIGITO}+)([eE][-+]?{DIGITO}+)?
INT ("-")?({DIGITO}+)([eE][-+]?{DIGITO}+)?
LONG {INT}(L|l)
IMAGINARY ({INT}|{FLOAT})(J|j)
KEYWORD   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|False|range
OPERATOR "+"|"-"|"*"|"/"|"%"|"&"|"|"|"^"|"~"|"<"|">"
DELIMITADORESCHAR "("|")"|"["|"]"|"="|";"|","|":"|"."
CARACTER ([^\n\*]([.])*)
STRING (\"|\')({CARACTER}*)(\"|\')

COMENTARIO "#".*

ASIGNACION {VARIABLE} = .*






%%




"**" {fprintf(yyout,"Exponente=%s",yytext);}
"//" {fprintf(yyout,"Div_Piso=%s ",yytext);}
"<<" {fprintf(yyout,"Bitewise_ri=%s ",yytext);}
">>" {fprintf(yyout,"Bitewise_le=%s ",yytext);}
"<=" {fprintf(yyout,"Menor_igual=%s ",yytext);}
">=" {fprintf(yyout,"Mayor_igual=%s ",yytext);}
"==" {fprintf(yyout,"Igual=%s ",yytext);}
"!=" {fprintf(yyout,"Diferente=%s ",yytext);}
"<>" {fprintf(yyout,"Diferente=%s ",yytext);}

">>=" {fprintf(yyout,"mayor_ig=%s ",yytext);}
"<<=" {fprintf(yyout,"menor_ig=%s ",yytext);}
"+=" {fprintf(yyout,"suma_asig=%s ",yytext);}
"-=" {fprintf(yyout,"resta_asig=%s ",yytext);}
"*=" {fprintf(yyout,"mult_asig=%s ",yytext);}
"/=" {fprintf(yyout,"div_asig=%s ",yytext);}
"//=" {fprintf(yyout,"floordiv=%s ",yytext);}
"&=" {fprintf(yyout,"andigual=%s ",yytext);}
"|=" {fprintf(yyout,"origual=%s ",yytext);}
"^=" {fprintf(yyout,"expigual=%s ",yytext);}
"**=" {fprintf(yyout,"exponente=%s ",yytext);}
"%=" {fprintf(yyout,"modulo=%s ",yytext);}


{KEYWORD} {
      int i=0;
      while(yytext[i]) {
            fprintf(yyout,"%c",toupper(yytext[i]));
            i++;
      }
   p_claves++;
}

{OPERATOR} {fprintf(yyout,"op=%s ",yytext);op++;}

{COMENTARIO} {}

{IMAGINARY} {fprintf(yyout,"IMAGINARY=%s ",yytext);}


{INT} {fprintf(yyout,"INT=%s ",yytext);}


{FLOAT} {fprintf(yyout,"FLOAT=%s ",yytext);}


{LONG} {fprintf(yyout,"LONG=%s ",yytext);}



{VARIABLE} {
      int result = add_word(yytext,0);
      fprintf(yyout,"Id%d= %s ", result, yytext);
}

{STRING} {fprintf(yyout,"str=%s ",yytext);str++;}
{DELIMITADORESCHAR} {
   switch ((char)*yytext)
   {
      case '(':
         fprintf(yyout,"parabre=%s ",yytext);
         break;
      case ')':
         fprintf(yyout,"parcierr=%s ",yytext);
         break;
      case '[':
         fprintf(yyout,"corabre=%s ",yytext);
         break;
      case ']':
         fprintf(yyout,"corcierr=%s ",yytext);
         break;
      case '=':
         fprintf(yyout,"asiggn= %s ",yytext);
         break;
      case ';':
         fprintf(yyout,"puntocoma=%s ",yytext);
         break;
      case ',':
         fprintf(yyout,"coma=%s ",yytext);
         break;
      case ':':
         fprintf(yyout,"dospunt=%s ",yytext);
         break;
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
      fprintf(yyout,"\nTabla de Identificadores \n");
      add_word("",1);
      printf("Acabo");
      return 0; 
} 
/* define a linked list of words and types */

struct word {
      char *word_name;
      struct word *next;
      };
struct word *word_list; /* first element in word list */
extern void *malloc() ;
int 
add_word(char *word,int a)
{      struct word *wp;
      int position = return_position(word,a);  
      if(lookup_word(word,a) != 0) {
      return position;     
      }      
    /* word not there, allocate a new entry and link it on the list */      
    wp = (struct word *) malloc(sizeof(struct word)); 
    wp->next = word_list; 
    /* have to copy the word itself as well */
    wp->word_name = (char *) malloc(strlen(word)+1);
    strcpy(wp->word_name, word);
    word_list = wp;
   return position;/* it worked */
    }

    int
    lookup_word(char *word,int a){
    struct word *wp = word_list;
    
    /* search down the list looking for the word */
      for(; wp; wp = wp->next) {
          int jj=0;
        if(a==1){
            fprintf(yyout,"Id= %s; \n",wp->word_name);
            if(jj==5){
                fprintf(yyout,"\n");
                jj=0;
            }
        }    
        if(strcmp(wp->word_name, word) == 0) 
        return 1;
       }      
       return 0;      /* not found */
}
    int
    return_position(char *word,int a){
    struct word *wp = word_list;
    
    /* search down the list looking for the word */
    int cont=0;
    int posi=0;
      for(; wp; wp = wp->next) {
        if(strcmp(wp->word_name, word) == 0){
           posi= cont+1;
        }
        cont++;
       }      
       return cont-posi;      /* not found */
}