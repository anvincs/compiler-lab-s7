%{
int COMMENT=0;
%}
identifier [a-zA-Z][a-zA-Z0-9]*
%%
#.* {printf("\n %s is a proprocessor directive", yytext);}
int|float|char|double|while|for|struct|typedef|do|if|break|continue|void|switch|return|else|goto {printf("\n\t %s is a keyword", yytext);}
"/*" {COMMENT = 1;}{printf("\n\t %s is a comment", yytext);}
{identifier}\( {if(!COMMENT) printf("\n Function %s \n\t", yytext);}
\{ {if(!COMMENT) printf("\n BLOCK BEGINS");}
\} {if(!COMMENT) printf("\n BLOCK ENDS");}
{identifier}(\[0-9]*\])? {if(!COMMENT) printf("\n %s is an IDENTIFIER", yytext);}
\".*\" {if(!COMMENT) printf("\n %s is a STRING", yytext);}
[0-9]+ {if(!COMMENT) printf("\n %s is a NUMBER", yytext);}
\)(\:)? {if(!COMMENT) printf("\n\t");ECHO;printf("\n");}
\( ECHO;
= {if(!COMMENT) printf("\n\t %s is an ASSIGNMENT OPERATOR", yytext);}
\<=|\>=|\<|\>|== {if(!COMMENT) printf("\n\t %s is a RELATIONAL OPERATOR", yytext);}
%%
int main() {
	FILE *file;
	file = fopen("var.c", "r");
	if(!file) {
		printf("Could not open the file");
		exit(0);
	}
	yyin = file;
	yylex();
	printf("\n");
	return 0;
}
int yywrap() {
	return 1;
}
