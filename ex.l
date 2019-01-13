%{
	#include "y.tab.h"

	int lineNo = 1;
	int colNo = 1;
	extern int first_line;
	extern int first_column;
%}

%%
"PROGRAM"			{ colNo+=7; return TOK_PROGRAM; }
"VAR"				{ colNo+=3; return TOK_VAR; }
"BEGIN"				{ colNo+=5; return TOK_BEGIN; }
"INTEGER"			{ colNo+=7;yylval.id = new char[strlen(yytext)+1]; strcpy(yylval.id,yytext); return TOK_INTEGER; }
"END"				{ colNo+=3; return TOK_END; }
"."				{ colNo++; return TOK_DOT; }
","				{ colNo++; return TOK_COMMA; }
"+"				{ colNo++; return TOK_PLUS; }
"-"				{ colNo++; return TOK_MINUS; }
"*"				{ colNo++; return TOK_MULTIPLY; }
"DIV"				{ colNo+=3; return TOK_DIVIDE; }
"("				{ colNo++; return TOK_LEFT; }
")"				{ colNo++; return TOK_RIGHT; }
";"				{ colNo++; return TOK_SEMICOL; }
":="				{ colNo+=2; return TOK_ASSIGN; }
":"				{ colNo++; return TOK_COL; }
"READ"				{ colNo+=4; return TOK_READ;}
"WRITE"				{ colNo+=5; return TOK_WRITE;}
"FOR"				{ colNo+=3; return TOK_FOR; }
"TO"				{ colNo+=2; return TOK_TO; }
"DO"				{ colNo+=2; return TOK_DO; }

([+-]?)0|[1-9][0-9]*	{ first_line = lineNo; first_column = colNo; colNo+=strlen(yytext); yylval.val = atoi(yytext); return TOK_NUMBER; }

[a-zA-Z][a-zA-Z0-9_]* { first_line = lineNo; first_column = colNo; colNo+=strlen(yytext); yylval.id = new char[strlen(yytext)+1]; strcpy(yylval.id,yytext); return TOK_ID;}
[ ]				{ colNo++; }
\r\n			{ lineNo++; colNo=1; }
\n				{ lineNo++; colNo=1; }
.				{ colNo++; return TOK_ERROR; }
%%
int yywrap(void) { return 1; }
