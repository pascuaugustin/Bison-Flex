/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOK_PROGRAM = 258,
    TOK_VAR = 259,
    TOK_BEGIN = 260,
    TOK_END = 261,
    TOK_SEMICOL = 262,
    TOK_COL = 263,
    TOK_COMMA = 264,
    TOK_DOT = 265,
    TOK_ASSIGN = 266,
    TOK_PLUS = 267,
    TOK_MINUS = 268,
    TOK_MULTIPLY = 269,
    TOK_DIVIDE = 270,
    TOK_LEFT = 271,
    TOK_RIGHT = 272,
    TOK_READ = 273,
    TOK_WRITE = 274,
    TOK_FOR = 275,
    TOK_DO = 276,
    TOK_TO = 277,
    TOK_ERROR = 278,
    TOK_NUMBER = 279,
    TOK_ID = 280,
    TOK_INTEGER = 281
  };
#endif
/* Tokens.  */
#define TOK_PROGRAM 258
#define TOK_VAR 259
#define TOK_BEGIN 260
#define TOK_END 261
#define TOK_SEMICOL 262
#define TOK_COL 263
#define TOK_COMMA 264
#define TOK_DOT 265
#define TOK_ASSIGN 266
#define TOK_PLUS 267
#define TOK_MINUS 268
#define TOK_MULTIPLY 269
#define TOK_DIVIDE 270
#define TOK_LEFT 271
#define TOK_RIGHT 272
#define TOK_READ 273
#define TOK_WRITE 274
#define TOK_FOR 275
#define TOK_DO 276
#define TOK_TO 277
#define TOK_ERROR 278
#define TOK_NUMBER 279
#define TOK_ID 280
#define TOK_INTEGER 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 119 "ex.y" /* yacc.c:1909  */
 char* id; int val; 

#line 109 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
