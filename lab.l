/*** ch can be accessed inside yylex()  
and main() ***/
%{ 
int count = 0; 
%} 
  
LETRA [a-z]
VARIBALE [a-z][a-z0-9]*
FLOAT ([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?
INT ([0-9]+)([eE][-+]?[0-9]+)? 
KEYWORD   "and"|"else"|"is"|"return"|"break"|"for"|"not"|"while"|"continue"|"if"|"or"|"def"|"import"|"pass"|"elif"|"in"|"print"|" "+[1-9][0-9]+?:
OPERATOR "+"|"-"|"*"|"**"|"/"|"//"|"%"|"<<"|">>"|"&"|"|"|"^"|"~"|"<"|">"|"<="|">="|"=="|"!="|"<>"
DELIMITADORES "("|")"|"["|"]"|"="|";"|","|":"|"."|">>="|"<<="|"+="|"-="|"*="|"/="|"//="|"&="|"|="|"^="|"**="|"%="

%% 
{LETRA} {printf("%s capital letter\n", yytext); 
       count++;} 
.     {printf("%s not a capital letter\n", yytext);} 
\n    {return 0;} 
%% 
  
/*** Code Section prints the number of 
capital letter present in the given input***/
int yywrap(){} 
int main(){ 
  
// Explanation: 
// yywrap() - wraps the above rule section 
/* yyin - takes the file pointer  
          which contains the input*/
/* yylex() - this is the main flex function 
          which runs the Rule Section*/
// yytext is the text in the buffer 
  
// Uncomment the lines below  
// to take input from file 
// FILE *fp; 
// char filename[50]; 
// printf("Enter the filename: \n"); 
// scanf("%s",filename); 
// fp = fopen(filename,"r"); 
// yyin = fp; 
  
yylex(); 
printf("\nNumber of Captial letters " 
      "in the given input - %d\n", count); 
  
return 0; 
} 
