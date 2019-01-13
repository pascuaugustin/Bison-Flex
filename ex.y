%{
	#include <stdio.h>
        #include <string.h>
	#include <stdlib.h>
	#include <iostream>

	int yylex();
	int yyerror(const char *msg);

	int yydebug = 1;
	
	int first_line;
	int first_column;

     int EsteCorecta = 1;
	char msg[500];

	class TVAR
	{
	     char* nume;
	     int valoare;
	     TVAR* next;
	  
	  public:
	     static TVAR* head;
	     static TVAR* tail;

	     TVAR(char* n, int v = -1);
	     TVAR();
	     int exists(char* n);
             void add(char* n, int v = -1);
             int getValue(char* n);
	     void setValue(char* n, int v);
	     void showTable();
	};

	TVAR* TVAR::head;
	TVAR* TVAR::tail;

	TVAR::TVAR(char* n, int v)
	{
	 this->nume = new char[strlen(n)+1];
	 strcpy(this->nume,n);
	 this->valoare = v;
	 this->next = NULL;
	}

	TVAR::TVAR()
	{
	  TVAR::head = NULL;
	  TVAR::tail = NULL;
	}

	int TVAR::exists(char* n)
	{
	  TVAR* tmp = TVAR::head;
	  while(tmp != NULL)
	  {
	    if(strcmp(tmp->nume,n) == 0)
	      return 1;
            tmp = tmp->next;
	  }
	  return 0;
	 }

	 void TVAR::showTable()
	 {
		TVAR* tmp = TVAR::head;
	 	while(tmp != NULL)
			{printf("%s %d\n",tmp->nume,tmp->valoare);
      			tmp = tmp->next;
			}
		
	 }

         void TVAR::add(char* n, int v)
	 {
	   TVAR* elem = new TVAR(n, v);
	   if(head == NULL)
	   {
	     TVAR::head = TVAR::tail = elem;
	   }
	   else
	   {
	     TVAR::tail->next = elem;
	     TVAR::tail = elem;
	   }
	 }

         int TVAR::getValue(char* n)
	 {
	   TVAR* tmp = TVAR::head;
	   while(tmp != NULL)
	   {
	     if(strcmp(tmp->nume,n) == 0)
	      return tmp->valoare;
	     tmp = tmp->next;
	   }
	   return -1;
	  }

	  void TVAR::setValue(char* n, int v)
	  {
	    TVAR* tmp = TVAR::head;
	    while(tmp != NULL)
	    {
	      if(strcmp(tmp->nume,n) == 0)
	      {
		tmp->valoare = v;
	      }
	      tmp = tmp->next;
	    }
	  }

	TVAR* ts = NULL;
%}


%union { char* id; int val; }

%token TOK_PROGRAM TOK_VAR TOK_BEGIN TOK_END TOK_SEMICOL TOK_COL TOK_COMMA TOK_DOT TOK_ASSIGN TOK_PLUS TOK_MINUS TOK_MULTIPLY TOK_DIVIDE TOK_LEFT TOK_RIGHT TOK_READ TOK_WRITE TOK_FOR TOK_DO TOK_TO TOK_ERROR 
%token <val> TOK_NUMBER
%token <id> TOK_ID TOK_INTEGER

%type <id> progname declist dec idlist type assign read write


%start prog

%left TOK_PLUS TOK_MINUS
%left TOK_MULTIPLY TOK_DIVIDE

%%
prog : 
		|
	TOK_PROGRAM progname TOK_VAR declist TOK_BEGIN stmtlist TOK_END TOK_DOT//{ts->showTable();}
		|
	error ';' prog
 	{ EsteCorecta = 0; }
		;
progname : TOK_ID;

declist : dec
	   |
	  declist TOK_SEMICOL dec;

dec : idlist TOK_COL type
	{
			
			char* found = strtok($1,",");
			
				
		while(found!=NULL)
	{
		if(ts != NULL)
			{
			if(ts->exists(found) == 0) ts->add(found);
	 		else
				{
				sprintf(msg,"%d:%d Eroare semantica: Declaratii multiple pentru variabila %s!",
						 @1.first_line, @1.first_column,found);
	   		 		yyerror(msg);
	    				YYERROR;
	  			}
				
			}
		else
	  	 {
		ts = new TVAR();
		ts->add(found);
	  	 }
		found=strtok(NULL,",");
	}
	};

type : TOK_INTEGER;

idlist : TOK_ID			
	    |
	 idlist TOK_COMMA TOK_ID{strcat($1,","); strcat($1,$3);};   

stmtlist : stmt
	    |
	   stmtlist TOK_SEMICOL stmt;

stmt : assign
	  |
	read
	  |
	write
	  |
	for;

assign : TOK_ID TOK_ASSIGN exp
	{
	if(ts != NULL)
	     {
			
	 	 if(ts->exists($1) == 1)
	 	  ts->setValue($1,1);			
	 	 else
	  	{
	    		sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!", 
					@1.first_line, @1.first_column, $1);
	    		yyerror(msg);
	    		YYERROR;
	  	}
	     }
	else
	{
	  sprintf(msg,"%d:%d Eroare semantica: Variabila %s este utilizata fara sa fi fost declarata!",
				 @1.first_line, @1.first_column, $1);
	  yyerror(msg);
	  YYERROR;	
	}
	};

exp : term
	|
       exp TOK_PLUS term
	|
       exp TOK_MINUS term;

term : factor 
	|
	term TOK_MULTIPLY factor
	|
       term TOK_DIVIDE factor;

factor : TOK_ID	
	   
	    |
	 TOK_NUMBER 
            |
	 TOK_LEFT exp TOK_RIGHT;

read : TOK_READ TOK_LEFT idlist TOK_RIGHT
	{
			
			char *found = strtok($3,",NULL");
			
		while(found!=NULL){
		
			
			if(ts->exists(found) == 0)
				{
				sprintf(msg,"%d:%d Eroare semantica: %s nu a fost declarata!",
						 @1.first_line, @1.first_column,found);
	   		 		yyerror(msg);
	    				YYERROR;
	  			}
				ts->setValue(found,1);
				found=strtok(NULL,",");
			}
		
	};

write : TOK_WRITE TOK_LEFT idlist TOK_RIGHT
	{
		
			char *found = strtok($3,",");
	
		while(found){
		
			
			if(ts->exists(found) == 0)
				{
				sprintf(msg,"%d:%d Eroare semantica: %s nu a fost declarata!",
						 @1.first_line, @1.first_column,found);
	   		 		yyerror(msg);
	    				YYERROR;
	  			}
			if(ts->getValue(found)==-1){
					sprintf(msg,"%d:%d Eroare semantica: %s nu a fost initializata!",
						 @1.first_line, @1.first_column,found);
	   		 		yyerror(msg);
	    				YYERROR;

				}
				//printf("PRINT %s\n", found);
				found=strtok(NULL,",");
			}
	};

for : TOK_FOR indexexp TOK_DO body ;

indexexp : TOK_ID TOK_ASSIGN exp TOK_TO exp
		{
		if(ts->exists($1) == 0)
				{
				sprintf(msg,"%d:%d Eroare semantica: %s nu a fost declarata!",
						 @1.first_line, @1.first_column,$1);
	   		 		yyerror(msg);
	    				YYERROR;
	  			}
			ts->setValue($1,1);		
		}

body : stmt
	|
	TOK_BEGIN stmtlist TOK_END;
%%

int main()
{
	yyparse();
	
	if(EsteCorecta == 1)
	{
		printf("Corecta!\n");		
	}	
	else
	{
		printf("Incorecta!\n");
	}

       return 0;
}

int yyerror(const char *msg)
{
	printf("Error: %s\n", msg);
	return 1;
}
