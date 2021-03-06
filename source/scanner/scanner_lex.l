%{

#include "token_type.h"
#include "../global/global.h"

#include <cstdlib>

// Contagem de erros l�xicos encontrados.
unsigned int scannerErrors = 0;

Scanner & scanner = ::oberonc.getScanner();


%}

%option noyywrap
%option nounput


    /* macros */
 		   
ws  	       [ \t\r]+
endline        [\n]
comment	       "//".*
letter 	       [A-Za-z]
digit  	       [0-9]
hex_digit      [0-9a-fA-F]
boolean        ("true"|"false") 
printable      ([^\\\"\n\r\t\0\xDD])|(\\x{hex_digit}{hex_digit})|(\\([\\\"nrt0]))
not_string_end [^\n\"]
string_error   "\""{not_string_end}*[\"\n]
id     	       ({letter}|"_")({letter}|{digit}|"_")* 
integer        {digit}+
string	       "\""{printable}*"\""

%%

    /* rules */
  
{ws}	 	   	{  /* do nothing */
                   
				   // Incrementa posi��o da coluna corrente.
                   yylloc.first_column += yyleng;  
				}

				
{endline}		{ 
                   yylloc.first_column = 1; // Volta para a primeira coluna.
 				   yylloc.first_line++;     // Incrementa posi��o da linha corrente.
				}

				
{comment}       {  /* do nothing */
                   
				   // Incrementa posi��o da coluna corrente.
                   yylloc.first_column += yyleng;  
				}

				
{boolean}	    { 
                   // Converte e atribui o valor booleano, representado pelo lexema, no membro correspondente
				   // da union "yylval", para uso posterior no Parser.
                   yylval.bool_value = scanner.getBooleanValueFromString(yytext);
 				   
				   // Chama m�todo debug para tratar o token lido.
				   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_BOOLEAN_LITERAL, yytext, yylloc.first_line, yylloc.first_column);
 				   
				   // Incrementa posi��o da coluna corrente.
				   yylloc.first_column += yyleng; 
				   
				   // Retorna tipo do token para o Parser.
				   return TOKEN_TYPE_BOOLEAN_LITERAL;
				}
				
				
{id}		    {   
                    // Verifica se este token corresponde a uma palavra chave ou simplesmente a um nome
                    // de identificador e retorna o tipo do token apropriado.
 	  			    TokenType tokenType = scanner.filterIdentifierTokenType(yytext);
					
					if(tokenType == TOKEN_TYPE_IDENTIFIER)
                    {
					   // Se o token representa simplesmente um nome de identificador, cria-se
					   // uma c�pia do lexema (nome do identificador em si).
                       char * identifier = new char[yyleng + 1];
                       strcpy(identifier, yytext);
	
	                   // Atribui o nome do identificador ao respectivo membro da union "yylval"
                       // para uso posterior no Parser.
  					   yylval.identifier = identifier;
                    }

					// Chama m�todo debug para tratar o token lido.
					::oberonc.getScannerDebugger()->debugToken(tokenType, yytext, yylloc.first_line, yylloc.first_column);
					
                    // Incrementa posi��o da coluna corrente.
                    yylloc.first_column += yyleng;

                    // Retorna tipo apropiado do token para o Parser.
					return tokenType;
                }
				
				
{integer}	    { 
                   // Converte e atribui o valor inteiro, representado pelo lexema, no respectivo membro
                   // da union "yylval", para uso posterior no Parser.
                   yylval.int_value = atol(yytext);
 				   
				   // Chama m�todo debug para tratar o token lido.
 				   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_INTEGER_LITERAL, yytext, yylloc.first_line, yylloc.first_column);
 				   
				   // Incrementa posi��o da coluna corrente.
				   yylloc.first_column += yyleng;
				   
				   // Retorna tipo do token para o Parser.
				   return TOKEN_TYPE_INTEGER_LITERAL;
			    }
				
				
{string}	    { 
                   // Cria uma c�pia da string identificada no arquivo fonte.
                   char * str = new char[yyleng + 1];
  				   strcpy(str, yytext);

	               // Atribui c�pia da string ao respectivo membro da union "yylval" para uso posterior
				   // no Parser.
 				   yylval.str_value = str;
 				   
				   // Chama m�todo debug para tratar o token lido.
	  	  	   	   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_STRING_LITERAL, yytext, yylloc.first_line, yylloc.first_column);
 				   
				   // Incrementa posi��o da coluna corrente.
				   yylloc.first_column += yyleng;
				   
				   // Retorna tipo do token para o Parser.
 				   return TOKEN_TYPE_STRING_LITERAL;
 				}

   /* 
      As a��es abaixo invocam o m�todo debugToken() para tratar os respectivos tokens lidos,
      bem como atualizam as posi��es correntes das colunas e retornam o tipo do token lido ao Parser.
   */
				
":="		    { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_ASSIGN, yytext, yylloc.first_line, yylloc.first_column);
  	 		       yylloc.first_column+=2; 
				   
				   return TOKEN_TYPE_ASSIGN;
				}

				
"<="		    { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_LESS_EQUAL, yytext, yylloc.first_line, yylloc.first_column);
 				   yylloc.first_column+=2;
				   
				   return TOKEN_TYPE_LESS_EQUAL;
			    }
				
				
">="		    { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_GREATER_EQUAL, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column+=2;
				   
				   return TOKEN_TYPE_GREATER_EQUAL;
	      	    }
				
				
":"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_COLON, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++; 
				   
				   return TOKEN_TYPE_COLON;
			    }


";"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_SEMICOLON, yytext, yylloc.first_line, yylloc.first_column); 
				   yylloc.first_column++; 
				  
				   return TOKEN_TYPE_SEMICOLON;
 			    }

				
"."		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_FULL_STOP, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++;

				   return TOKEN_TYPE_FULL_STOP;
		        }


","		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_COMMA, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++; 
				   
				   return TOKEN_TYPE_COMMA;
			    }


"+"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_PLUS, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++;

				   return TOKEN_TYPE_PLUS;
				}


"-"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_MINUS, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++; 
				   
				   return TOKEN_TYPE_MINUS;   
	 		    }


"*"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_ASTERISK, yytext, yylloc.first_line, yylloc.first_column);
                   yylloc.first_column++; 
				   
				   return TOKEN_TYPE_ASTERISK;
		        }


"/"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_SLASH, yytext, yylloc.first_line, yylloc.first_column); 
				   yylloc.first_column++; 
				   
				   return TOKEN_TYPE_SLASH;
				}


"="		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_EQUAL, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++; 
				  
				   return TOKEN_TYPE_EQUAL; 
				}


"#"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_NOT_EQUAL, yytext, yylloc.first_line, yylloc.first_column);
 				   yylloc.first_column++;
				   return TOKEN_TYPE_NOT_EQUAL;
 			    }


"<"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_LESS, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++;
				   
				   return TOKEN_TYPE_LESS;
	      	    }


">"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_GREATER, yytext, yylloc.first_line, yylloc.first_column); 
                   yylloc.first_column++;
				   
				   return TOKEN_TYPE_GREATER; 
                }


"("		        {
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_LEFT_BRACKET, yytext, yylloc.first_line, yylloc.first_column); 
                   yylloc.first_column++;
				   
				   return TOKEN_TYPE_LEFT_BRACKET;
 			    }


")"		        { 
                   ::oberonc.getScannerDebugger()->debugToken(TOKEN_TYPE_RIGHT_BRACKET, yytext, yylloc.first_line, yylloc.first_column);
				   yylloc.first_column++;
				   
				   return TOKEN_TYPE_RIGHT_BRACKET;
				}



    /*
    	Caso especial para detec��o do erro l�xico relativo � n�o finaliza��o de uma string.
	*/		
	
{string_error}  {
                   if(yytext[yyleng-1] != '\"')
                   {
				      if(yytext[yyleng-1] == '\n')
					   {
 	         		      yylloc.first_line++;
				       }
					   
				       // Chama m�todo debug para tratar o erro encontrado.
                       ::oberonc.getScannerDebugger()->debugUnterminatedStringError(yytext, yylloc.first_line, yylloc.first_column);
 				  
  				       yylloc.first_column += yyleng;
                   }
                   else
                   {
				      // Chama m�todo debug para tratar o erro encontrado.
                      ::oberonc.getScannerDebugger()->debugInvalidStringCharacterError(yytext, yylloc.first_line, yylloc.first_column);
	 
                 	  yylloc.first_column += yyleng;
                   }
     

                   // Incrementa n�mero de erros l�xicos encontrados.
                   scannerErrors++;
                   
                   // N�O se retorna o token de erro para o Parser para que este continue a
                   // an�lise sint�tica.
 			    } 


   /*
       Demais erros l�xicos: s�mbolos inv�lidos.
   */
.               {
                     
                   // String inicializada e fim de arquivo inesperado encontrado.   					
	               if(yytext[0] == '\"')
				   {
				      // Chama m�todo o debug para tratar o erro encontrado.
				      ::oberonc.getScannerDebugger()->debugUnexpectedEOF(yylloc.first_line);
					  
                      // Incrementa n�mero de erros l�xicos encontrados.
					  scannerErrors++;
					  
					  // Termina execu��o do Scanner e retorna EOF inesperado ao Parser.
				      yyterminate();
				   }
				   else
				   {
				      // Chama m�todo o debug para tratar o erro encontrado.
                      ::oberonc.getScannerDebugger()->debugInvalidSymbolError(yytext, yylloc.first_line, yylloc.first_column);
 				      yylloc.first_column += yyleng;
				   
                      // Incrementa n�mero de erros l�xicos encontrados.
                      scannerErrors++;

                      // N�O se retorna o token de erro para o Parser para que este continue a
                      // an�lise sint�tica.
				   }

			    } 
				
%%